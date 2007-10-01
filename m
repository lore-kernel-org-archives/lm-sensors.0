From: Dick Middleton <dick@fouter.net>
Date: Mon, 01 Oct 2007 19:23:47 +0000
Subject: [lm-sensors] k8temp does produce sensible results
Message-Id: <47014943.9080104@fouter.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I wonder if somebody could throw some light on the following.  I have a new AMD 
690 based mobo.  It seems to need k8temp sensor driver.  The i2c_piix4 module 
also get loaded.

The data produced by sensors is complete rubbish:

k8temp-pci-00c3
Adapter: PCI adapter
Core0 Temp:
              +11 C
Core0 Temp:
              -11 C
Core1 Temp:
               +2 C
Core1 Temp:
               +4 C

I notice the sensors.conf file has no computations for this chip so I assume it 
is supposed to produce correct answers directly:

chip "k8temp-*"

    label temp1 "Core0 Temp"
    label temp2 "Core0 Temp"
    label temp3 "Core1 Temp"
    label temp4 "Core1 Temp"

Does anybody know what is happening here and whether there is any resolution to 
this problem available?

Many thanks

Dick



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
