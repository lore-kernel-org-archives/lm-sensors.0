From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 30 May 2013 08:47:41 +0000
Subject: Re: [lm-sensors] Configuration file for Intel D2500CC mini-ITX board
Message-Id: <20130530104741.2a18e809@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20130529150440.4e021553@obraro.integrasoft.ro>
In-Reply-To: <20130529150440.4e021553@obraro.integrasoft.ro>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 30 May 2013 10:40:42 +0300, SZENTE Balint wrote:
> I have read the relevant parts from the Intel Atom Datasheet and I
> believe now I figured out what should be the limits.
> 
> Table 4-30 from the "Intel Atom Processor D2000 and N2000 Series
> Datasheet, Vol. 1" contains two voltage specifications
> <http://www-ssl.intel.com/content/dam/doc/datasheet/atom-d2000-n2000-vol-1-datasheet.pdf>:
> 
>  VCC_HFM:
>   - Vcc at Highest Frequency Mode (HFM)
>   - Range 0.91V - 1.21V, depending on the calibrated individual
>     voltage identification value (VID)
> 
>  VCC_LFM: only for CPUs with SpeedStep feature
>   - Vcc at Lowest Frequency Mode (LFM)
>   - Range 0.70/0.75 - 0.90V, depending on VID
> 
> The Intel D2500CC mini-ITX board has an Intel Atom D2500 soldered on
> it which lacks the SpeedStep technology, so one can say that the proper
> Vcore limits for this specific mainboard are:
> 
> label   in0            "Vcore"
> set     in0_min        0.91
> set     in0_max        1.21
> 
> Can you fix this on the Wiki page?

Done, thanks for the update!

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
