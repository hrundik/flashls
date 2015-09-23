package org.mangui.hls {
import flash.net.NetConnection;

import org.mangui.hls.event.HLSEvent;

import org.mangui.hls.stream.HLSNetStream;

public class ZeroConfigHLSNetStream extends HLSNetStream {
    private static function createNetConnection():NetConnection {
        var connection : NetConnection = new NetConnection();
        connection.connect(null);
        return connection;
    }

    private var _zeroHLS:ZeroConfigHLS;

    public function ZeroConfigHLSNetStream() {
        super(createNetConnection(), (ZeroConfigHLS._netStream = this, _zeroHLS = new ZeroConfigHLS()), _zeroHLS._streamBuffer);
        _zeroHLS.addEventListener(HLSEvent.MANIFEST_LOADED, onManifestLoaded);
    }

    override public function play(...rest):void {
        var file:String = rest[0];
        _zeroHLS.load(file);
    }

    private function onManifestLoaded(event:HLSEvent):void {
        super.play(null, -1);
    }

    public function get hls():HLS {
        return _zeroHLS;
    }
}
}

import org.mangui.hls.HLS;
import org.mangui.hls.ZeroConfigHLSNetStream;
import org.mangui.hls.stream.HLSNetStream;

class ZeroConfigHLS extends HLS {
    public static var _netStream:ZeroConfigHLSNetStream;

    public function ZeroConfigHLS() {
    }
    override protected function createNetStream():HLSNetStream {
        return _netStream;
    }
}
