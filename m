From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 01 Nov 2005 16:33:48 +0000
Subject: [lm-sensors] SiS630 sensors.conf errors
Message-Id: <20051101163322.36e372ae.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051030235843.GF26397@paradise.net.nz>
In-Reply-To: <20051030235843.GF26397@paradise.net.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Volker,

> Minor bugs, but can be confusing:
> 
>   # The following is for the Inside Technologies 786LCD which uses either a
>   # IT8705F or a SIS950 for monitoring with the SIS630.
>   # You will need to load the it87 module as follows to select the correct
>   # temperature sensor type.
>   # modprobe it87 temp_type=0x31
> 
> Module it87 doesn't have a temp_type option.

It used to, but has no more. Thanks for reporting. I've dropped that
part, as well as the comment about the misdetection in the paragraph
right after, as I believe this is no more true.

> The settings for low and high temperature values are missing for all
> temperatures.

This is only an example. You are free to change, delete or add
statements. Also feel free to submit a patch to etc/sensors.conf.eg if
you think it's worth it.

Thanks,
-- 
Jean Delvare
