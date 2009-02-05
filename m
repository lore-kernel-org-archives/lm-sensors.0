From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 05 Feb 2009 08:38:12 +0000
Subject: Re: [lm-sensors] [PATCH 4/4] libsensors: Read extra configuration
Message-Id: <20090205093812.46c1dd9b@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090204230519.7a473034@hyperion.delvare>
In-Reply-To: <20090204230519.7a473034@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Luca,

On Wed, 4 Feb 2009 23:37:14 +0100, Luca Tettamanti wrote:
> On Wed, Feb 4, 2009 at 11:05 PM, Jean Delvare <khali@linux-fr.org> wrote:
> > --- lm-sensors.orig/lib/init.c  2009-02-04 17:52:51.000000000 +0100
> > +++ lm-sensors/lib/init.c       2009-02-04 17:52:51.000000000 +0100
> > @@ -100,6 +106,47 @@ exit_cleanup:
> >        return err;
> >  }
> >
> > +static int config_file_filter(const struct dirent *entry)
> > +{
> > +       return entry->d_type = DT_REG
> > +           || entry->d_type = DT_LNK
> > +           || entry->d_type = DT_FIFO;
> > +}
> 
> Hum, why pipes?

No good reason. I checked the list of DT_* constants, excluded the ones
I knew wouldn't work, and kept the remaining ones. I thought that
someone might come up with a specific scenario where using a named pipe
to somehow generate configuration files would make sense. But honestly
I have no idea what such a scenario would be.

So probably it's better to remove DT_FIFO for now. Thanks!

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
