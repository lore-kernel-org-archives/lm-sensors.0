From: Luca Tettamanti <kronos.it@gmail.com>
Date: Thu, 11 Nov 2010 16:46:53 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] intel_mid_thermal: clean up
Message-Id: <AANLkTi=0c7+miKMKb1dO5GYeeq-SFCXZvkgsVys+=Mes@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101111154919.12776.42338.stgit@localhost.localdomain>
In-Reply-To: <20101111154919.12776.42338.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Nov 11, 2010 at 4:49 PM, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> From: Alan Cox <alan@linux.intel.com>
>
> Polish and tidy
> - Use pr_fmt
> - Printing prune
> - Tidy comments/spelling
> - Handle errors registering with the thermal zone
> - Propogate errors back from conversion more cleanly
> - Remove name based hack in identifying direct channel

Hi Alan,
this is a new driver, why are you sending a separate incremental patch
with fixes instead of a single one?

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
