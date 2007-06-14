From: "Juerg Haefliger" <juergh@gmail.com>
Date: Thu, 14 Jun 2007 16:21:54 +0000
Subject: Re: [lm-sensors] Possible support for the SMSC SCH5317? (found on
Message-Id: <191fb4ca0706140921k5394bfedy76aeea780726a72f@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <46711ACE.3070809@onelan.co.uk>
In-Reply-To: <46711ACE.3070809@onelan.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Simon,

Could you run sensors-detect and post the output?

Thanks
...juerg


On 6/14/07, Simon Farnsworth <simon.farnsworth@onelan.co.uk> wrote:
> Hello,
>
> We're trying to work out how we monitor temperatures in HP dc7700
> machines, and we've been looking for possibly interesting chips on the
> motherboard.
>
> We've found an SMSC SCH5317, which we suspect is related to the SMSC
> SCH5017 SuperIO and thermal diode monitoring chip, but we can't find
> documentation for it on the web (it's not mentioned on SMSC's web site).
> We've tried the dme1737 driver mentioned on the wiki, together with all
> drivers in mainline 2.6.21, but none of them pick it up.
>
> Has anyone else encountered one of these chips? If so, have you been
> able to get lm-sensors to read temperatures out of it?
> --
> Thanks in advance for any help,
>
> Simon Farnsworth
>
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
