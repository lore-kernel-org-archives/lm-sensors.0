From: phil@netroedge.com (phil@netroedge.com)
Date: Thu, 19 May 2005 06:23:34 +0000
Subject: Thermal fan on PIIIDME
Message-Id: <20020619162228.Q1893@Stimpy.netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020618234918.44766.qmail@web13106.mail.yahoo.com>
In-Reply-To: <20020618234918.44766.qmail@web13106.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


If you want to experiment, you could try to disable initialization in
the lm87.c module.  Edit this:

        /* Initialize the LM87 chip */
        lm87_init_client(new_client);
        return 0;

to:

        /* Initialize the LM87 chip */
        /* lm87_init_client(new_client); */
        return 0;

Then rebuild/reinstall/whatever...

And see what you get.  You can also examine the lm87_init_client
function if you want to see exactly what it is doing.

Let me know what you find out!


Phil

On Thu, Jun 20, 2002 at 12:11:08AM +0100, Chris Rankin wrote:
>  --- phil@netroedge.com wrote: > 
> > Oh, boy, I'm not sure.  It sounded like the fan was
> > controlled by an
> > LM87.  What controls the LM87?  It seems obvious to
> > me that the LM87's
> > must be controlled exclusively through the SMBus. 
> > It's possible that
> > ACPI (or some other Bios thing?) is controlling the
> > LM87 via the
> > SMBus, but I'm not an ACPI expert. 
> 
> Just "for laughs", I rebooted without loading the i2c
> modules (i2c-i801, lm87, eeprom and dependents) and I
> am now hearing the sound of the thermal fan! So what
> we have now is a classic catch-22 because I can no
> longer know whether the fan is cutting in at the
> correct temperature!
> 
> Chris
> 
> 
> __________________________________________________
> Do You Yahoo!?
> Everything you'll ever need on one web page
> from News and Sport to Email and Music Charts
> http://uk.my.yahoo.com

-- 
Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
   phil@netroedge.com -- http://www.netroedge.com/~phil
 PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
