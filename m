From: Erik Brakkee <erik@brakkee.org>
Date: Tue, 12 Apr 2011 11:37:20 +0000
Subject: [lm-sensors] System instability with Supermicro X8DTi-F and
Message-Id: <4DA43970.6040605@brakkee.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,


I encountered major system instability when using the w83795 module 
together with fancontrol on a X8DTI-F motherboard running opensuse 11.3. 
The processor is an Intel Xeon L5630.
I did the experiments early this year with version 0.7 of the driver. 
Actually fancontrol really worked well, keeping the system really quiet.

However, I experienced random hangs of the system and also there were a 
lot of events in the logs such as these:

    1 | 12/16/2010 | 14:30:02 | Fan #0x13 | Lower Non-critical going low
    2 | 12/16/2010 | 14:30:02 | Fan #0x13 | Lower Critical going low
    3 | 12/16/2010 | 14:30:03 | Fan #0x13 | Lower Non-recoverable going low
    4 | 12/16/2010 | 14:30:05 | Fan #0x13 | Lower Non-recoverable going low
    5 | 12/16/2010 | 14:30:06 | Fan #0x13 | Lower Critical going low
    6 | 12/16/2010 | 14:30:06 | Fan #0x13 | Lower Non-critical going low

The theory somehow was that there was concurrent access by the embedded BMC controller and the driver.

After disabling fancontrol the system went from highly unstable to rock solid. I even tried monitoring the system at periodic intervals using the w83795 driver and that resulted in the same types of events, exactly coinciding with the periodic polling.

In other words, I am quite clear that this is related to the driver or at least an interworking between the driver and the embedded BMC.

I have now switched off fancontrol permanently but would like to eventually enable it again because the system is just much more quiet (it is a home server with low load).

Any suggestions? Have similar problems been found?

Cheers
   Erik





_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
