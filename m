From: hvw59601@yahoo.com (Hugo Vanwoerkom)
Date: Fri, 17 Jun 2005 00:14:20 +0000
Subject: [lm-sensors] fixing ticket #1944
Message-Id: <20050616221404.37371.qmail@web31002.mail.mud.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050615222035.91224.qmail@web31003.mail.mud.yahoo.com>
In-Reply-To: <20050615222035.91224.qmail@web31003.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

I obviously owe you one. If I can be of help anytime,
give a holler.
Output of sensors is below. Looks right, might need be
tweaked. Temp1 23 degrees? The room temp here is 29
degrees.
Thanks again!


--- Jean Delvare <khali@linux-fr.org> wrote:

> Hi Hugo,
> 
> 
> 
> Patch attached. It was quite easy as you can see. Of
> course, after we
> have a datasheet and know the differences between
> the W83627THF and the
> W83687THF chips, there will probably be some
> adjustments needed.
> 


Script started on Thu 16 Jun 2005 05:03:52 PM CDT
/Thu Jun 16-17:03:52HDB1# sensors
w83687thf-isa-0290
Adapter: ISA adapter
VCore 1:   +1.68 V  (min =  +0.70 V, max =  +1.87 V)  
           
VCore 2:   +3.33 V  (min =  +1.78 V, max =  +3.38 V)  
           
+3.3V:     +2.72 V  (min =  +3.73 V, max =  +3.54 V)  
           
+5V:       +4.97 V  (min =  +1.42 V, max =  +5.56 V)  
           
+12V:      +0.00 V  (min =  +0.00 V, max =  +0.00 V)  
           
V5SB:      +5.05 V  (min =  +6.32 V, max =  +5.51 V)  
           
VBat:      +3.09 V  (min =  +1.95 V, max =  +4.02 V)  
           
fan1:        0 RPM  (min = 8544 RPM, div = 2)         
           
fan2:     3813 RPM  (min = 2824 RPM, div = 2)         
           
fan3:        0 RPM  (min = 2872 RPM, div = 2)         
           
temp1:       +23?C  (high =   -84?C, hyst =  +118?C)  
sensor = thermistor   ALARM   
temp2:     +50.5?C  (high =   +76?C, hyst =   +71?C)  
sensor = diode           
temp3:     +44.5?C  (high =   +76?C, hyst =   +71?C)  
sensor = thermistor           
vid:      +0.000 V  (VRM Version 9.0)
alarms:   
beep_enable:
          Sound alarm disabled

/Thu Jun 16-17:04:00HDB1# exit

Script done on Thu 16 Jun 2005 05:04:05 PM CDT


		
__________________________________ 
Discover Yahoo! 
Get on-the-go sports scores, stock quotes, news and more. Check it out! 
http://discover.yahoo.com/mobile.html
