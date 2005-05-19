From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:28 +0000
Subject: Fwd: lm_sensors and Tyan Tiger
Message-Id: <3C3BA680.DC266AA9@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I haven't found any reference to the -AM or -WM versions
in the datasheet or the Winbond web site
and so don't have any more information for you.
Sorry.
You can try changing the sensor type to see if that
fixes the temperatures.
mds

> Subject: lm_sensors and Tyan Tiger
> Date: Thu, 3 Jan 2002 17:44:07 +0100
> From: mewis@sun1.kww.bauing.tu-darmstadt.de (Peter Mewis)
> To: mdsxyz123@yahoo.com
> 
> Hi,
> 
> are there any plans to support the W83627HF-AM chip?
> 
> I have a Tyan Tiger S2460 MP board. My system
> hung when I modprobed the w83781d module. In the
> tickets I found two things right:
> 1. I could load the module without hanging up by:
>    modprobe w83781d init=0
> 2. The reading where a bit more realistic, when
>    I refreshed the senor-data in the BIOS before
>    booting.
> Nevertheless the temperatures are wrong.
> On the mainboard I found a W83627HF-AM chip. It seems
> that sehh@altered.com in ticket 730 is right, that the
> chip is to be initialized in a different way.
> He suggested to contact qnx@telia.com for more information.
> (Maybe also the readings differ for the MP-board?)
> 
> Thanks for your help
> Best regards
> Peter
