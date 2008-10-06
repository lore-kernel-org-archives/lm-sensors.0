From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 06 Oct 2008 10:24:56 +0000
Subject: Re: [lm-sensors] [PATCH 0/2] hwmon: w83781d: converting to
Message-Id: <20081006122456.660608b3@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <48CB7DC8.3060503@grandegger.com>
In-Reply-To: <48CB7DC8.3060503@grandegger.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Wolfgang,

On Sat, 13 Sep 2008 10:46:00 +0200, Wolfgang Grandegger wrote:
> I made another effort to convert the w83781d to new-style binding. The
> series consists of the following two patches:
> 
>   [PATCH 1/2] hwmon: w83781d: make ISA interface depend on CONFIG_ISA
>   [PATCH 2/2] hwmon: w83781d: use new style driver binding
> 
> I have tested it one a PowerPC MPC8544 board. I did not have any
> occasion to verify the ISA related part.

Sorry for the late answer and thanks for working on this. I am
currently building a kernel on a test machine, which has a W83781D
chip on the ISA bus. I will review and test your patches later today.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
