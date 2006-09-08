From: michaelnel@comcast.net (Michael Nelson)
Date: Fri, 08 Sep 2006 01:43:35 +0000
Subject: [lm-sensors] Asus P5B Deluxe WiFi AP Sensors
Message-Id: <20060908014335.GA7239@seahunt.dyndns.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060822145643.GA5632@seahunt.dyndns.org>
In-Reply-To: <20060822145643.GA5632@seahunt.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I have the output making more sense now:

w83627ehf-isa-0290
Adapter: ISA adapter
Case Fan:  878 RPM  (min = 1704 RPM, div = 8)
CPU Fan:  2057 RPM  (min = 84375 RPM, div = 4)
Power Fan: 975 RPM  (min = 168750 RPM, div = 8)
MB Temp:     +30??C  (high =   +35??C, hyst =   +40??C)
CPU Temp:  +51.0??C  (high = +70.0??C, hyst = +40.0??C)

I guess I need to fix up those min values for the fans though...

... but no voltages are shown.  Michael in Germany, can you share your
sensors.conf stuff for this chip and board with me please?

Thanks
Michael in USA

-- 

San Francisco, CA

