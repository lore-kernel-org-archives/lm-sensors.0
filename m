From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:31 +0000
Subject: I2C Question
Message-Id: <3FE8C5FF.6090903@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <BAY13-DAV55rtOhmWyC00006ec4@hotmail.com>
In-Reply-To: <BAY13-DAV55rtOhmWyC00006ec4@hotmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

you may wish to research your sodimm question at www.jedec.org.
If you have a 24RF08 it may or may not be on the same bus as your sodimm.
There may be a battery connector standard out there, go look.
If you're that desperate to talk to your 24rf08 you should be able
to figure out how to bypass the code in our package that
prevents access.

Arkadiy Pomerantsev wrote:
> 
> Hello
>  
> On your hardware hacking page located at 
> http://secure.netroedge.com/~lm78/hardhack.html, you have a blank DIMM 
> module that woul allow taping into SMBus.  Is there a similar device for 
> SODIMM 144 pin? 
>  
> Also I noticed that lm_sensors has a problem with thinkpad 24rf08 
> eeprom, is it safe to assume that 24rf08 eeprom on thinkpads is 
> connected to SMBus, and if the blank SODIMM module (mentioned above) 
> exists, would it allow access to the 24rf08 EEPROM?
>  
> Lastly, are you aware of any external access points to thinkpad SMBus?  
> Like through a battery connector maybe?  If the battery connector has 
> SMBus pins it, would you know which pins those are?
>  
> Thank you for you help
> Arkadiy
