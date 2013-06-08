From: Hans de Goede <hdegoede@redhat.com>
Date: Sat, 08 Jun 2013 13:04:13 +0000
Subject: Re: [lm-sensors] Missing Fintek F71868AD chip
Message-Id: <51B32BCD.5040603@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <51B329D9.30802@orange.fr>
In-Reply-To: <51B329D9.30802@orange.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

On 06/08/2013 02:55 PM, Avrel Vor wrote:
> Hello,
>
> The mother board MSI FM2-A55M-E33 includes a Super I/O chip Fintek F71868AD.
> So far it is not recognised by sensors-detect :
> "
> Trying family `VIA/Winbond/Nuvoton/Fintek'...               Yes
> Found unknown chip with ID 0x1106
> "
> Is it possible to test a modification of the script to force the use of the driver "f71882gf" with this ID ?
> I am afraid of the risk of damaging the mother board...
>

I don't see a data-sheet for it here:
http://www.fintek.com.tw/eng/products.asp?BID=1&SID

So it is impossible to tell. The safe thing to do is to contact fintek for
a datasheet, once we've that we can see if an existing driver can be
easily modified to support this new chip.

Note the 0x11 part of the id suggests it is a newer family then any of the
ones which we do support, still it might be quite similar, we really cannot
tell without a datasheet.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
