From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 27 Jun 2007 08:18:28 +0000
Subject: Re: [lm-sensors] Separate package for i2c tools
Message-Id: <20070627101828.3479702b@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070625111244.1ca5327a@hyperion.delvare>
In-Reply-To: <20070625111244.1ca5327a@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Axel,

On Mon, 25 Jun 2007 11:22:30 +0200, Axel Thimm wrote:
> On Mon, Jun 25, 2007 at 11:12:44AM +0200, Jean Delvare wrote:
> > Axel, how can I create a brand new project in SVN? Do I need your help?
> 
> Not really (but see below for acls), technically it is one project, so
> all you need to do is
> 
> svn mkdir my-new-project
> 
> at the top level next to lm_sensors and i2c.

This is so easy :) OK, done that.

> The only thing that I need to do is setting up the acls in the httpd
> config you want to use on that project. It can be
> lm-sensors-commiters, i2c-commiters or something new.

That would be something new: i2c-tools-commiters. This is an
essentially separate package, that could have developers with no
interest in sensors at all. And i2c-commiters is a restricted group, so
it wouldn't fit either.

BTW, how come that I was allowed to create and fill the i2c-tools
directory before you created the new group? Am I almighty or something? ;)

> > Is it possible to preserve the history while moving the files from one
> > project to another?
> 
> Just use svn mv instead of svn rm/del and svn add. Move operations are
> like copy and delete, and copy operations are crossed over when
> traversing history unless you explicitely use --stop-on-copy.

Wow, very nice.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
