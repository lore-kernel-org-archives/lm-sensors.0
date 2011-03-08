From: "R, Durgadoss" <durgadoss.r@intel.com>
Date: Tue, 08 Mar 2011 06:23:34 +0000
Subject: Re: [lm-sensors] [PATCH:hwmon:v4:]Merging_pkgtemp_with_coretemp
Message-Id: <D6D887BA8C9DFF48B5233887EF0465410947330AC3@bgsmsx502.gar.corp.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1299101865-10797-1-git-send-email-durgadoss.r@intel.com>
In-Reply-To: <1299101865-10797-1-git-send-email-durgadoss.r@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

> > > Subject: [PATCH:hwmon:v4:]Merging_pkgtemp_with_coretemp
> > >
> > > This patch merges the pkgtemp driver with the coretemp driver.
> > > This merged driver creates one hwmon device per physical CPU.
> > >
> > > Changes from v3 of this patch:
> > > Added appropriate support for CONFIG_HOTPLUG_CPU.
> > >
> 
> Problem is that you don't provide a complete changelog ... meaning I have no

I shall provide a complete changelog for all versions of this patch, from now on.

> if you addressed the crash problem I reported earlier, much less how you

I tested these patch sets on a Core i5 machine, I did not get any crash.
That's why I did not talk about this.
But If you can send me the crash logs,
I shall look into them and try to reproduce and see
What is going on .. 

> 
> In other words, you are loading a lot of work on me. I don't have the time for

Sorry for that.

> right now, so you'll have to be patient.

I tested these patch sets on some boards that I have.
Since I am too new to this, I do not know whether I covered all
Corner cases. There is a fair chance that something might break..
Hence, I would wait for these patches to be tested
and reviewed by you at your convenience.

Thanks,
Durga

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
