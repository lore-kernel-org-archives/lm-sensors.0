From: jerj@coplanar.net (Jeremy Jackson)
Date: Thu, 19 May 2005 06:25:20 +0000
Subject: getting 2.8.7 or better for 2.6 kernel?
Message-Id: <417DA305.9050304@coplanar.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <4178A7BD.9070607@coplanar.net>
In-Reply-To: <4178A7BD.9070607@coplanar.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
>>I tried the patch with a Dell Optiplex GX110.  The module loads, finds
>>a device at 0x09, but says it's "not activated".  What do you need to 
>>debug this problem?
> 
> 
> You mean, what do *you* need to work around it? ;)

Yeah, that's what I meant.
> 
> Typically, disabled devices mean that the monitoring device is not wired
> properly (the motherboard manufacturer didn't make use of the
> functionality). Thus, the driver has not been educated to forcibly
> enable the device.

Well the BIOS has temp., voltage and fan readings, and there are no 
other sensor chips on the board.
> 
> You may still want to try to manually enable it, and see if the driver
> then reports anything useful. The commands to do that are (in order):
> 
> isaset 0x2e 0x2f 7 9
> isaset 0x2e 0x2f 0x30 1 1

What is the last trailing one for?

Now, the modprobe command gives:
pc87360: Base address not set for device 0x09
> 
> Then loading the driver should work. Whether or not you will find it
> useful on your board, you tell us.

-- 
Jeremy Jackson
Coplanar Networks
(519)897-1516
http://www.coplanar.net
