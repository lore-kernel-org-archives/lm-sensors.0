From: Andre Prendel <andre.prendel@gmx.de>
Date: Wed, 24 Feb 2010 20:24:27 +0000
Subject: Re: [lm-sensors] [RFC PATCH v1 0/2] Add the sensors-config tool
Message-Id: <20100224202427.GA1914@andre-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100219193821.GA1917@andre-laptop>
In-Reply-To: <20100219193821.GA1917@andre-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Feb 24, 2010 at 02:58:56PM +0100, Hans de Goede wrote:
> Hi,
> 
> Having multiple directory levels is fine by me. I was merely
> pointing out that there are some issues with that approach.
> 
> Thinking of this another possible issue is that vendors don't
> always use the same vendor string in the DMI data.
> 
> So I think that the following would be a good solution:
> 
> 1 dir per vendor, with vendor board configs in there, just like
> the wiki.
> 
> symlinks in the base dir following the symlink structure I suggested
> earlier.
> 
> This way we get the best of both worlds I think.

Sounds good. I will take some time to revise the tool and come with an
updated version.

> Regards,
> 
> Hans

Thanks,
Andre

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
