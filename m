From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Wed, 24 Oct 2007 17:16:47 +0000
Subject: Re: [lm-sensors] [PATCH 6/6] Make /etc/sensors3.conf the default
Message-Id: <471F7DFF.7080808@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071024172810.55f3a250@hyperion.delvare>
In-Reply-To: <20071024172810.55f3a250@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Use /etc/sensors3.conf as the default configuration file. If it can't
> be found, fallback to /etc/sensors.conf. This allows for an old
> libsensors and a new libsensors to be installed in parallel, and each
> one has its own configuration file.
> 

I've reviewed the entire patch set and it looks good to me. you forgot to 
update the libsensors.3 manpage in patch1, but thats remedied by patch6

Regards,

hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
