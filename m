From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 29 May 2011 07:09:23 +0000
Subject: Re: [lm-sensors] Working configuration for intel D945GCLF
Message-Id: <20110529090923.77c7e3bb@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <BANLkTikVJz5rUrtdHEY82Lc8yoggnyA8HA@mail.gmail.com>
In-Reply-To: <BANLkTikVJz5rUrtdHEY82Lc8yoggnyA8HA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Marcelo,

On Sat, 28 May 2011 11:00:28 +0100, Marcelo Coelho wrote:
> Hi,
> 
> I don't have a wiki account, so anyone that has one can put this in
> 
> intel/D945GCLF ?

Done:
http://www.lm-sensors.org/wiki/Configurations/Intel/D945GCLF

Thanks for your contribution.

>     label in7 "+1.8V"
>     set in7_min  1.8 * 0.90
>     set in7_max  1.8 * 1.10

Presumably this is the DDR2 memory module voltage? What does the BIOS
say?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
