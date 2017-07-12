package cn.sixstar.server;

import javax.imageio.ImageIO;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.RemoteEndpoint;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.nio.ByteBuffer;
import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;

/**
 * className
 * @author Administrator
 */
// 使用ServerEndpoint，指定一个URL地址，客户端js可以使用websocket对象通过这个URL地址链接后台
// （和servletmapping映射是一样的）
@ServerEndpoint(value = "/server") // Tomcat管理的，
public class OnlineServer {
	// 用一个线程安全的集合来存放每个客户端的实例
	private static final List<OnlineServer> clients = new CopyOnWriteArrayList<OnlineServer>();
	// 客户端连接后的会话对象，由web应用服务器来创建
	private Session session;
	/**
	 * 当客户端简历链接成功时，会触发的事件
	 * @param session
	 */
	@OnOpen
	public void onOpen(Session session) throws IOException {
		this.session = session;
		clients.add(this);
		System.out.println("有新的连接进入!! 当前的客户端数：" + clients.size());
	}
	@OnClose
	public void onClose() {
		clients.remove(this);
		System.out.println("有连接断开!! 当前的客户端数：" + clients.size());
	}
	//客戶端发送的消息，服务端接受的信息，然后发送到onmessage这个注解中来，然后知道是哪个发送的消息过来
	@OnMessage
	public void onMessage(String message, Session session) throws IOException {
      System.out.println(message);
		// 进行消息的转发
		for (OnlineServer client : clients) {
			//    拿到回话，拿到基本的发送方式，发送文本格式（直接发送消息）
			client.session.getBasicRemote().sendText(message);
		}
	}

	/**
	 * 接收客户端发送的字节流
	 *
	 * @param message
	 */
	@OnMessage(maxMessageSize = 10000000)
	public void OnMessage(ByteBuffer message) {
		broadcast2Others(message);
	}

	@OnError
	public void OnError(Throwable t) throws Throwable {
		t.printStackTrace();
	}

	/**
	 * 广播给除了自己外的用户
	 *
	 * @param msg
	 */
	private <T> void broadcast2Others(T msg) {
		long start = System.currentTimeMillis();
		if (msg instanceof ByteBuffer) {
			ByteBuffer buffer = (ByteBuffer) msg;
			byte[] bytes = new byte[buffer.capacity()];
			buffer.get(bytes, 0, bytes.length);
//			try {
//				BufferedImage image = ImageIO.read(new ByteArrayInputStream(bytes));
//				// 保存到本地看下效果
//				saveBytes2Image(image);
//			} catch (IOException e) {
//				e.printStackTrace();
//			}
			buffer.position(0);
		}
		for (OnlineServer client : clients) {
			if (!this.equals(client)) {
				client.call(msg);
			}
		}

		long end = System.currentTimeMillis();
		System.out.println("转发处理用时：" + (end - start) + "ms");
	}

	private void saveBytes2Image(BufferedImage image) {
		try {
			String dir = "/ws-test";// 存放目录，tomcat所在盘符目录下
			File folder = new File(dir);
			if (!folder.exists()) {
				folder.mkdirs();
			}
			// 文件类型选择png或jpg，png的比较大
			ImageIO.write(image, "jpg", new File(dir + "/" + System.currentTimeMillis() + ".jpg"));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 异步方式向客户端发送消息
	 *
	 * @param msg
	 *            参数类型为String或ByteBuffer
	 */
	protected <T> void callAsync(T msg) {
		RemoteEndpoint.Async remote = this.getSession().getAsyncRemote();
		if (msg instanceof String) {
			remote.sendText((String) msg);
		} else if (msg instanceof ByteBuffer) {
			remote.sendBinary((ByteBuffer) msg);
		}
	}

	private <T> void call(T msg) {
		try {
			synchronized (this) {
				RemoteEndpoint.Basic remote = this.getSession().getBasicRemote();
				if (msg instanceof String) {
					remote.sendText((String) msg);
				} else if (msg instanceof ByteBuffer) {
					remote.sendBinary((ByteBuffer) msg);
				}
			}
		} catch (IOException e) {
			try {
				this.getSession().close();
			} catch (IOException e1) {
				// Ignore
			}
			onClose();
		}
	}

	private Session getSession() {
		return this.session;
	}
}
