From: marcin_ml@sekretarka.no-ip.org (Marcin =?iso-8859-2?q?Ka=B3u=BFa?=)
Date: Thu, 19 May 2005 06:24:58 +0000
Subject: NForce2 ATXP1 clockchip - progress
Message-Id: <200405181234.44847.marcin_ml@sekretarka.no-ip.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi
About that  driver - so far I've moved the funcionality of the 8dravcore into 
the module, which I'll send you probably tomorrow when I'll do the cosmetics.
But now there's the hard part: Since I don't have any clues how to talk to the 
chip about clocks, I did it the hard way
Here is what I got:
The program is using in/out commands to write dwords into CF8 and CFC 
addresses and my question is - how to translate what I got into linux 
i2c_smbus... commands? Since it writes dwords instead of bytes I'm not sure 
what they do... And I don't know why it is using CF8 as base address instead 
of 5000 as it is in linux (can this be configured or is it using a different 
bus??)
The 'conversation' to read the clocks from MB is as follows (I don't know what 
is happening before except that it's scanning the bus (I think so at 
least...) and it produces a lot of trash in debugs)
data			register
80000000	<- CF8	check status?
800000A0	-> CF8	some command? (does 80 in the beginning mean PEC?) what does 
A0 mean? register address or a command?
00000000	-> CFC	writting data?
80000000	<- CF8     check the status once again?

80000000	<- CF8	check status?
800000A4	-> CF8	some command? (does 80 in the beginning mean PEC?)
004AF71F	<- CFC	these are FSB settings and I know how to encode/decode them 
80000000	-> CF8    don't know...

80000000	<- CF8	check status?
80000378	-> CF8	some command? (does 80 in the beginning mean PEC?)
2001500F	<- CFC	PCI/AGP settings
80000000	<- CF8     check the status once again?

This is what I got after sniffing all actions after pressing "get clocks" 
button and it does read them, but I don't know how to reproduce it using 
linux functions because I know little about i2c/smbus protocol. Does anybody 
have any idea? Or do you need more info - I know this isn't everything 
because there's nothing with the 0x37 chip address so probably it's 
initialized somewhere earlier.
Thanks
Martin
