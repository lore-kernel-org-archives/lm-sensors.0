From: Andy Lutomirski <luto@amacapital.net>
Date: Fri, 23 Aug 2013 00:30:59 +0000
Subject: Re: [lm-sensors] [PATCH v4 0/2] iMC SMBUS and DIMM bus probing
Message-Id: <CALCETrWyr4s-nGtwNRxOicZfwisr4G3fUVj8u_g3c_gy8=ygfg@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <cover.1374171757.git.luto@amacapital.net> <20130815125047.GF17155@katana>
In-Reply-To: <20130815125047.GF17155@katana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, James Ralston <james.d.ralston-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

On Thu, Aug 15, 2013 at 5:50 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
> On Thu, Jul 18, 2013 at 11:36:52AM -0700, Andy Lutomirski wrote:
>> Intel LGA2011 machines have dedicated SMBUS controllers for DIMM
>> sockets.  Because they're dedicated, they can be safely and accurately
>> probed, since all devices on them are known to be attached to DIMMs.
>> The devices found are:
>>  - SPD EEPROMs
>>  - TSODs (Temperature Sensor on DIMMs)
>>  - Other interesting things, with drivers hopefully to follow...
>
> Just to let you know, I keep thinking about it now and then but have not
> made up my mind yet... still at it.
>

I've written the updated version of the driver.  Can you give me an
opinion on the dimm bus stuff so I can minimize the number of times I
have to ask for permission to send the driver?

(There aren't any huge changes -- the main thing is that it will now
refuse to run on some systems.)

Thanks,
Andy

-- 
Andy Lutomirski
AMA Capital Management, LLC

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
