From: mbm@livewiredev.com (MBM Support)
Date: Thu, 19 May 2005 06:24:55 +0000
Subject: PC87360
Message-Id: <FJEPJHGHDGKMMPFFGCLOEEDFEPAA.mbm@livewiredev.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040428215454.35072dc9.khali@linux-fr.org>
In-Reply-To: <20040428215454.35072dc9.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

hi Jean

officially I do and I got it working for one users board long long ago, but
to be honest I can't be bothered, tis not used that much (at least get very
few reports) and those that do use it I get so wacked out readings that I
ignored them

I don't like the way it works and the way you need to communicate with it

I am only getting 2 voltages of it

			    IOByte(SIOVB+$09,$05,IOWrite);
                      Voltage[1]:=((1.211 * 2.50) *
IOByte(SIOVB+$0B,$0,IORead) / 256);         //core0

                      Voltage[2]:%5;

                      IOByte(SIOVB+$09,$06,IOWrite);
                      Voltage[3]:=((2.45 * 2.50) *
IOByte(SIOVB+$0B,$0,IORead) / 256);         //3.3

                      Voltage[4]:%5;
                      Voltage[5]:%5;
                      Voltage[6]:%5;
                      Voltage[7]:%5;


how correct they are.... as I said worked great for one user :)
Regards, Alex

- Please always attach all previous mails !
----------------------------------------------------------------------
The Motherboard Monitor:
http://mbm.livewiredev.com/
----------------------------------------------------------------------
For long you live and high you fly,
And smiles you'll give and tears you'll cry,
And all you touch and all you see,
Is all your life will ever be.
----------------------------------------------------------------------



-----Original Message-----
From: Jean Delvare [mailto:khali@linux-fr.org]
Sent: woensdag 28 april 2004 21:55
To: MBM Support
Cc: sensors@stimpy.netroedge.com
Subject: PC87360



Hi Alex,

Have you been working on the National Semiconductor PC87360 family of
Super-I/O chips yet? I am working on this these days, especially the
most featured of them all, the PC87366. There are a number of data
missing from the datasheets (such as the recommendations about
resistors, and order of voltage inputs). If you are supporting this chip
or plan to do so, let's share our knowledge about these chips :) I'm
already almost done with the fans and diode-based temperatures.

Thanks.

--
Jean Delvare
http://khali.linux-fr.org/
