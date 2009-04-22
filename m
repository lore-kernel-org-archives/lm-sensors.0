From: "Mark E. Hansen" <meh@Winfirst.Com>
Date: Wed, 22 Apr 2009 15:04:18 +0000
Subject: Re: [lm-sensors] lm_sensors support for Dell PowerEdge R200 and Nat
Message-Id: <49EF31F2.9020201@Winfirst.Com>
List-Id: <lm-sensors.vger.kernel.org>
References: <49EE1186.7060100@Winfirst.Com>
In-Reply-To: <49EE1186.7060100@Winfirst.Com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 04/21/09 21:04, Matt Roberds wrote:
> On Tue, 21 Apr 2009, Mark E. Hansen wrote:
>> I've install lm_sensors 2.10 (from an RPM: lm_sensors-2.10.7-4.el5)
>> and run sensors-detect.
> 
> Old version is old.  :)  You might at least grab the latest and greatest
> sensors-detect at
> http://www.lm-sensors.org/browser/lm-sensors/trunk/prog/detect/sensors-detect?format=txt
> and see what it says.  sensors-detect is independent of the rest of the
> sensors package; you can run it even if you don't have lm_sensors
> installed.  (You do need Perl, but if an old version of sensors-detect
> works, you already have that.)

Actually, that link provides sensors-detect version 5291, which is the
same version installed with the 2.10 version of lm_sensors that came
with CentOS 5.3, so the results were the same.

> 
> http://www.lm-sensors.org/ticket/2182 has a little more information on
> this particular chip; apparently there is more than one chip that gets
> detected as this one.  That page mentions a recent (Feb 2009) change to
> sensors-detect to better figure out which chip you actually have.

Is there a newer version of sensors-detect? Perhaps the link provided
above was not to the latest version?

> 
> If you go into the BIOS setup, are sensor values (voltages, fan speeds)
> displayed in there?  If there is an "enable sensors" setting, make sure
> it is turned on.

This will be difficult, as the machine is in a secured machine room and
has no console. However, I will ask the system admin to have a look at
these.

Thanks,


> 
> Matt Roberds
> 



-- 
Mark Hansen, PP-ASEL, Instrument Airplane, USUA Ultralight Pilot
Cal Aggie Flying Farmers
Sacramento, CA

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
