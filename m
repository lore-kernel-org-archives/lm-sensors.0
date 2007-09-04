From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 04 Sep 2007 08:35:25 +0000
Subject: Re: [lm-sensors] [PATCH 7/7] libsensors4: Don't store scaling
Message-Id: <20070904103525.60e5ebb6@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070902222333.6a46e91b@hyperion.delvare>
In-Reply-To: <20070902222333.6a46e91b@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Mon, 03 Sep 2007 19:53:05 +0200, Hans de Goede wrote:
> Jean Delvare wrote:
> > Note that the structures sensors_chip_feature and sensors_feature_data
> > are now exactly the same, so we could use one structure everywhere.
> > The only advantage to have two structures is that sensors_feature_data
> > is part of the API, while sensors_chip_feature is not, so if we
> > ever need to add internal attributes, for example to improve performance,
> > having an internal structure can be helpful. Question is, will we
> > actually ever need this? Opinion anyone?
> 
> I think it would be better to make them one and the same structure then, to 
> avoid confusion.

I tend to agree, however I will wait to be done with the API review and
changes before doing it, just in case.

Thanks for the reviews!

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
