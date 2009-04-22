From: "Mark E. Hansen" <meh@Winfirst.Com>
Date: Wed, 22 Apr 2009 15:49:03 +0000
Subject: Re: [lm-sensors] lm_sensors support for Dell PowerEdge R200 and Nat
Message-Id: <49EF3C6F.5070506@Winfirst.Com>
List-Id: <lm-sensors.vger.kernel.org>
References: <49EE1186.7060100@Winfirst.Com>
In-Reply-To: <49EE1186.7060100@Winfirst.Com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 04/22/09 08:29, Jean Delvare wrote:
> On Wed, 22 Apr 2009 08:04:18 -0700, Mark E. Hansen wrote:
>> On 04/21/09 21:04, Matt Roberds wrote:
>> > On Tue, 21 Apr 2009, Mark E. Hansen wrote:
>> >> I've install lm_sensors 2.10 (from an RPM: lm_sensors-2.10.7-4.el5)
>> >> and run sensors-detect.
>> > 
>> > Old version is old.  :)  You might at least grab the latest and greatest
>> > sensors-detect at
>> > http://www.lm-sensors.org/browser/lm-sensors/trunk/prog/detect/sensors-detect?format=txt
>> > and see what it says.  sensors-detect is independent of the rest of the
>> > sensors package; you can run it even if you don't have lm_sensors
>> > installed.  (You do need Perl, but if an old version of sensors-detect
>> > works, you already have that.)
>> 
>> Actually, that link provides sensors-detect version 5291, which is the
>> same version installed with the 2.10 version of lm_sensors that came
>> with CentOS 5.3, so the results were the same.
> 
> The link above points to a version of sensors-detect which doesn't
> include its version number. So, if you think it's version 5291, you
> haven't looked at the right file.
> 
> That being said,
> http://dl.lm-sensors.org/lm-sensors/files/sensors-detect
> is the preferred download location now, as this one does have the
> version number included.
> 

Well, that worked better. Here is the pertinent output:

Driver `coretemp':
  * Chip `Intel Core family thermal sensor' (confidence: 9)

Driver `ipmisensors':
  * ISA bus, address 0xca8
    Chip `IPMI BMC KCS' (confidence: 8)

However, it seems these drivers are not loaded. In looking at
the Drivers wiki, it seems kernel patches may be needed. However,
I've not done that before. Can some kind person provide a step-by-
step on what I need to do to get lm-sensors working?

My OS again is CentOS 5.3, kernel 2.6.18-128.1.6.el5

Thanks for any help!


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
