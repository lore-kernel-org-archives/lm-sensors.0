From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 25 Aug 2014 00:33:29 +0000
Subject: Re: [lm-sensors] Fintek F71868AD
Message-Id: <53FA8459.4040600@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <CALefuyhPk2GP7-XCb=hWtnuWj5PU-Ve8d_Ydgb1T3QDAeaLL3Q@mail.gmail.com>
In-Reply-To: <CALefuyhPk2GP7-XCb=hWtnuWj5PU-Ve8d_Ydgb1T3QDAeaLL3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 08/24/2014 11:51 AM, Ben Barker wrote:
> Hi,
>
> I have an MSI A78M-E45 motherboard.
>
> So far as I can tell, it uses a Fintek F71868AD sensor chip. Running
> sensors-detect gives:
>
> Trying family `VIA/Winbond/Nuvoton/Fintek'...               Yes
> Found unknown chip with ID 0x1106
>      (logical device 4 has address 0x295, could be sensors)
>
>
> Looking online there seems to have been some discussion of this about a
> year ago, but nothing for some time:
>
> http://www.lm-sensors.org/changeset/6190
>
> Is there any likelihood of this being supported?

The chip seems to be somewhat compatible with F71869A.
You could try "modprobe f71882fg force_id=0x1007" and see
if you get anything useful.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
