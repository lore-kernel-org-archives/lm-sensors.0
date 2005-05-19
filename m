From: info@wore.ma.cx (wore)
Date: Thu, 19 May 2005 06:25:52 +0000
Subject: SMSC LPC47M192 SMBus question
Message-Id: <87hdi76hst.wl@wore.ma.cx>
List-Id: <lm-sensors.vger.kernel.org>
References: <87vf6ua498.wl@wore.ma.cx>
In-Reply-To: <87vf6ua498.wl@wore.ma.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

> I just checked the datasheet and they definitely are. They better be
> anyway, because they have the same identification registers.

You are right. I saw the description in the smsc47m15x's datasheet.
47m15x: http://www.smsc.com/main/tools/discontinued/47m15x.pdf
47m192: http://www.smsc.com/main/datasheets/47m192.pdf

> I just added detection of these chips to our sensors-detect script.

Thanks.
Then, I got detect routine from prog/detect/sensors-detect.

Finally, I think I have finished writing.
I need testers on 2.4 kernel and porters for 2.6 kernel.

here's some results (some values are strange)

$ cat /proc/sys/dev/sensors/smsc47m192-i2c-0-2d/temp*
-11.0 -92.0 34.0
-69.0 125.0 31.0
-19.0 58.0 30.0

$ cat /proc/sys/dev/sensors/smsc47m192-i2c-0-2d/in*
1.99 2.17 2.48
2.80 1.33 1.48
2.02 3.00 3.36
2.26 2.89 5.13
11.93 5.43 12.18
2.91 1.67 2.75

-- 
wore
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smsc47m192.c
Type: application/octet-stream
Size: 11702 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050416/06a8c6f9/smsc47m192.obj
