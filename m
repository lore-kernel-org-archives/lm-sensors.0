From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:31 +0000
Subject: VID specifications
Message-Id: <3CBEB764.C4261708@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Thanks for the great research and suggestions.
We'll have to think of the best way to incorporate them.

If we brought vrm out to /proc we could have a simple program
that does the following:
# fixvrm
	Which VID is correct:
		1) 3.2V (VRM 8.2) (default)
		2) 2.55V (VRM 8.5)
		3) 1.675V (VRM 9.0)
	Enter number 1-3: 1
	Your VID calculation has been changed to 1.675 V (VRM 9.0)


Trent Piepho wrote:
> 
> I've been getting lm_sensors working with my tyan tiger mp (more on that
> later) and I noticed that the VID was reporting the wrong core voltage.  I
> tracked down the problem and figured out what was going on.
> 
> The w83781d driver, and lots of others (lm87 I know too, because I fixed a vid
> problem with that driver) use a single macro VID_FROM_REG to convert the 4 or
> 5 vid lines into a core voltage, with 10 mV units.  The macro follows a spec
> called the VRM 8.2 DC-DC Converter Specification, you can get a pdf at intel's
> site.  The AthlonXP processor, and I assume all socket A chips, uses a newer
> specification called VRM 9.0.  There is also a VRM 8.1, 8.3, and 8.4, but they
> are all mostly compatible with 8.2.  VRM 9.0 is *not* backward compatible with
> VRM 8.2.  There is also a VRM 8.5, which is used with Pentium III Tualatin
> processors, that isn't compatible with VRM 8.2.
> 
> In order to get proper VID support, the user needs to be able to specify the
> processor's VRM version.  Since the code to do this conversion is the same for
> any sensor chip, it makes sense not to put a separate copy in each driver.  It
> would be nice if it could be specified in the sensors.conf file, e.g. "set vrm
> 9.0".  Most drivers look at the vid setting to set the initial voltage limits
> for the cpu voltage line.  In order to do this correctly, the driver would
> need to know the setting when it initializes the chip.
> 
> There is also a problem with the units.  The newer VRM specifications use
> increments of 25 mV instead of 50 or 100 mV, so the 10mV resolution used in
> the driver isn't enough.  ie. magnitude for vid needs to be 3 instead of 2.
> 
> Here is code to handle the different VRM versions.  I'm not sure if the VRM
> 8.5 code will work, as it's not totally clear how the VID lines will be hooked
> up.
> 
> /* VRM 8.2 - 8.4:  Used for Pentium II-III chips */
> #define VID_FROM_REG(val) ((val)=0x1f?0:(val)>=0x10?510-(val)*10:\
>                            205-(val)*5)
> 
> /* VRM 8.5:  Used for Pentium III-S Tualatin chips */
> #define VID_FROM_REG(val) ((val)=0x1f?0:  ((((val)&16)?2.5:0) + \
>                            ((val)>4?205:125) - ((val)&15)*5))
> 
> /* VRM 9.0:  Used for Pentium IV and AMD Socket A */
> #define VID_FROM_REG(val) ((val)=0x1f?0:(185-(val)*2.5))
