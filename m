From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 09 Nov 2007 13:19:02 +0000
Subject: Re: [lm-sensors] LM75: "ERROR: Can't get temperature data!"
Message-Id: <20071109141902.14752d62@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1194039013.25315.2.camel@louie>
In-Reply-To: <1194039013.25315.2.camel@louie>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Michael,

On Tue, 06 Nov 2007 18:45:06 -0600, Michael Brian Willis wrote:
> On Tue, 2007-11-06 at 22:51 +0100, Jean Delvare wrote:
> > Unrelated to your problem, but it seems to me that your clock is slightly off ;)
> Just slightly :) I just haven't set up my ntp server yet. 
> 
> > But this one does not! The attributes are in a subdirectory ("lm75")
> > instead of being directly in the device's directory. libsensors doesn't
> > expect this and fails. The lm75 driver in the vanilla kernel does NOT
> > do this, so I suspect that you're using a modified driver.
> I am using the LM75 driver that comes with the Denx embedded linux
> kernel. I found the place in the LM75 driver (drivers/hwmon/lm75.c)
> where it specifies the attributes to be placed in a separate folder: 
> 
> static const struct attribute_group lm75_group = {
> 	
> 	//don't put attritube files in a separate folder
> 	//.name  = "lm75",
> 	.attrs = lm75_attributes,
> };
> 
> Commenting out the .name line fixes the problem and I can now read
> temperature data from the LM75. 
> 
> Thank you so much for all of your help! I'm very glad to get this issue
> resolved. 

Glad to know. That's really weird from Denx to have done that, as it
breaks lm-sensors as you can see, and I fail to see what advantage
there can be to have the attributes in a subfolder anyway. Feel free to
complain loudly to them for wasting everybody's time.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
