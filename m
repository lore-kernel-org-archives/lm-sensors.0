From: perrye@gilfillan.org (Perry Gilfillan)
Date: Thu, 19 May 2005 06:25:17 +0000
Subject: voodoo3 3000, Fedora 2, lm_sensors, and tv-out
Message-Id: <415A2914.1030307@gilfillan.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4159F327.8080607@edgedesign.us>
In-Reply-To: <4159F327.8080607@edgedesign.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Philip Edelbrock wrote:
> Ah, I didn't realize you were trying to do this under a 2.6.x kernel 
> (which I think FC2 is, check /proc/version).  We haven't ported the 
> bt869 driver over yet.  I think last we heard Berni (b-gruber@gmx.de) 
> was working on the port.  Check with him, or use a 2.4.x kernel.
> 
> Sorry for the hassle.
> 
> 
> Phil
> 
> Marion Bates wrote:
> 
>> Wow, thanks for replying so fast!
>>
>> I found another howto, very similar to Ollila's, here: 
>> http://www.perturb.org/content/linux-voodoo3.txt  and at least it gave 
>> me some diagnostic commands to run. Here they are, with their output:
>> [...]

I have received a patch for the bt869 on 2.6.x from another V3TV user, 
but have not had time to work with it, except to clean up the white 
space, and I guesss T.Reed has not forwarded it to the sensors list 
himself yet, so I'll do it now ;)

Here is what T.Reed wrote at the time:
 > Curiousity got the better of me and I ended up porting the bt869
 > driver to work with the 2.6.8.1 kernel. Attached is a diff taken in
 > /usr/src/linux/drivers/i2c. I started with the lm_sensors-2.8.7
 > version of bt869.c and used a diff between lm_sensors ds1621.c and the
 > 2.6 version of ds1621.c to guide me through the porting process (that,
 > and numerous compiler errors  :)

And these are my findings on functionality:
 > As for functionality, I had more problems than you.  640x480 works out
 > of the box as the default mode, but I could not test any other modes
 > because the encoder seems to shut down as soon as I touch any of the
 > /sys/bus/i2c/devices/*/* files, even just to cat the current values.
 > The 640x480 would go to a blue screen when I try to cat some value,
 > and test any other mode was futile because echoing to any of the files
 > would result in a blue screen.

I have to reload the module to get output working again.

I've barely skimmed the data sheet, so can't offer any improvements at 
this time.

Marion Bates wrote:
 >
 > eeprom-i2c-0-50
 > Adapter: I2C Voodoo3/Banshee adapter
 > Unknown EEPROM type (255).
 >
 > (I dunno what that's supposed to be telling me, but here it is
 > anyway.)
 >

The eeprom module will get false positive hits on i2c clients on the 
voodoo3 i2c bus.  You will need to include the line 'option eeprom 
checksum=1' in modules.conf or modprobe.conf to prevent this.

I think the false hit you saw would be for the ddcmon client.

Are you in fact using a 2.6.x kernel?  With a 2.6 kernel you would look 
in /sys/bus/i2c/devices/?-0044/

Cheers,

Perry
-----
Gilfillan Family: http://www.gilfillan.org/

Projects:
   V3TV:		http://www.gilfillan.org/v3tv/
   VPX3224:	http://www.gilfillan.org/vpx3224/
   V3TV-V4L2:	http://www.gilfillan.org/v3tv-v4l2/
   snd-tvmixer:	http://www.gilfillan.org/ALSA/
                 http://v3tv.sourceforge.net/

-------------- next part --------------
A non-text attachment was scrubbed...
Name: bt869-for-linux-2.6.diff
Type: text/x-patch
Size: 30136 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040928/af4554b6/bt869-for-linux-2.6.bin
