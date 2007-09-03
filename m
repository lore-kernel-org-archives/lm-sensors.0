From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Mon, 03 Sep 2007 17:53:05 +0000
Subject: Re: [lm-sensors] [PATCH 7/7] libsensors4: Don't store scaling
Message-Id: <46DC4A01.30805@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070902222333.6a46e91b@hyperion.delvare>
In-Reply-To: <20070902222333.6a46e91b@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Now that we can deduce the scaling factor required for each feature
> from its type, there's no need to store this scaling factor. We can
> instead compute it at runtime. This saves some memory (about 10 kB
> in my real-world test), and the runtime overhead is totally
> negligible.
> 

Looks good.

> Note that the structures sensors_chip_feature and sensors_feature_data
> are now exactly the same, so we could use one structure everywhere.
> The only advantage to have two structures is that sensors_feature_data
> is part of the API, while sensors_chip_feature is not, so if we
> ever need to add internal attributes, for example to improve performance,
> having an internal structure can be helpful. Question is, will we
> actually ever need this? Opinion anyone?
> 

I think it would be better to make them one and the same structure then, to 
avoid confusion.

Regards,

Hans


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
