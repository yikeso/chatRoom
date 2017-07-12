package indi.anyesu.action;

import java.io.IOException;
import java.nio.ByteBuffer;
import java.util.List;
import java.util.Map;
import java.util.concurrent.CopyOnWriteArrayList;

import javax.websocket.EndpointConfig;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

/**
 * Websocket 音频通讯
 * 
 * @author anyesu
 */
@ServerEndpoint(value = "/websocket/chat/audio", configurator = wsConfigurator.class)
public class AudioController extends AbstractWSController {
	private static final List<AbstractWSController> connections = new CopyOnWriteArrayList<AbstractWSController>();

	@OnOpen
	public void OnOpen(Session session, EndpointConfig config) {
		// 设置用户信息
		Map<String, List<String>> map = session.getRequestParameterMap();
		setSession(session);
		if (map.get("uid") == null) {
			try {
				this.getSession().close();
			} catch (IOException e) {
			}
		}
		setUserName(map.get("uid").get(0));
		super.OnOpen(session, config);
	}

	@OnClose
	public void OnClose() {
		super.OnClose();
	}

	@OnMessage(maxMessageSize = 10000000)
	public void OnMessage(String message) {
		System.out.println("1:"+message);
		super.OnMessage(message);
	}

	@OnMessage(maxMessageSize = 10000000)
	public void OnMessage(ByteBuffer message) {
		System.out.println("2:"+message);
		super.OnMessage(message);
	}

	@OnError
	public void OnError(Throwable t) throws Throwable {
	}

	@Override
	List<AbstractWSController> getConnections() {
		return connections;
	}

	@Override
	String getConnectType() {
		return "audio";
	}

}
