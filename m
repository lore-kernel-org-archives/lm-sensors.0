From: Andre Prendel <andre_prendel@gmx.de>
Date: Fri, 20 Feb 2009 12:20:59 +0000
Subject: Re: [lm-sensors] [Patch 2/2] libsensors: Use __func__ in
Message-Id: <20090220122059.GC4260@ubuntu>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090220090213.GB4260@ubuntu>
In-Reply-To: <20090220090213.GB4260@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Feb 20, 2009 at 12:00:08PM +0100, Jean Delvare wrote:
> Hi Andre,

Hello Jean,
 
> On Fri, 20 Feb 2009 10:02:13 +0100, Andre Prendel wrote:
> > Unified sensors_fatal_error() calls. Use __func__ to get the function name.
> > 
> > ---
> >  access.c     |    3 +--
> >  conf-parse.c |    2 +-
> 
> conf-parse.c is a generated file. You must patch conf-parse.y instead.

thanks for the hint. I will send a new patch.
> 
> >  data.c       |    2 +-
> >  general.c    |    7 +++----
> >  4 files changed, 6 insertions(+), 8 deletions(-)
> > 
> > --- lm-sensors-dev/lib/access.c	2009-02-16 14:12:50.000000000 +0100
> > +++ my-sensors/lib/access.c	2009-02-19 22:36:39.000000000 +0100
> > @@ -201,8 +201,7 @@ char *sensors_get_label(const sensors_ch
> >  	
> >  sensors_get_label_exit:
> >  	if (!label)
> > -		sensors_fatal_error("sensors_get_label",
> > -				    "Allocating label text");
> > +		sensors_fatal_error(__func__, "Allocating label text");
> >  	return label;
> >  }
> >  
> > --- lm-sensors-dev/lib/conf-parse.c	2009-02-17 22:46:54.000000000 +0100
> > +++ my-sensors/lib/conf-parse.c	2009-02-19 22:36:34.000000000 +0100
> > @@ -1941,7 +1941,7 @@ sensors_expr *malloc_expr(void)
> >  {
> >    sensors_expr *res = malloc(sizeof(sensors_expr));
> >    if (! res)
> > -    sensors_fatal_error("malloc_expr","Allocating a new expression");
> > +    sensors_fatal_error(__func__, "Allocating a new expression");
> >    return res;
> >  }
> >    
> > --- lm-sensors-dev/lib/data.c	2009-02-16 14:12:50.000000000 +0100
> > +++ my-sensors/lib/data.c	2009-02-19 22:36:38.000000000 +0100
> > @@ -88,7 +88,7 @@ int sensors_parse_chip_name(const char *
> >  			return -SENSORS_ERR_CHIP_NAME;
> >  		res->prefix = strndup(name, dash - name);
> >  		if (!res->prefix)
> > -			sensors_fatal_error("sensors_parse_chip_name",
> > +			sensors_fatal_error(__func__,
> >  					    "Allocating name prefix");
> >  		name = dash + 1;
> >  	}
> > 
> > --- lm-sensors-dev/lib/general.c	2009-01-26 17:43:43.000000000 +0100
> > +++ my-sensors/lib/general.c	2009-02-19 22:34:41.000000000 +0100
> > @@ -34,8 +34,7 @@ void sensors_malloc_array(void *list, in
> >  
> >  	*my_list = malloc(el_size*A_BUNCH);
> >  	if (! *my_list)
> > -		sensors_fatal_error("sensors_malloc_array",
> > -				    "Allocating new elements");
> > +		sensors_fatal_error(__func__, "Allocating new elements");
> >  	*max_el = A_BUNCH;
> >  	*num_el = 0;
> >  }
> > @@ -59,7 +58,7 @@ void sensors_add_array_el(const void *el
> >  		new_max_el = *max_el + A_BUNCH;
> >  		*my_list = realloc(*my_list, new_max_el * el_size);
> >  		if (! *my_list)
> > -			sensors_fatal_error("sensors_add_array_el",
> > +			sensors_fatal_error(__func__,
> >  					    "Allocating new elements");
> >  		*max_el = new_max_el;
> >  	}
> > @@ -77,7 +76,7 @@ void sensors_add_array_els(const void *e
> >  		new_max_el -= new_max_el % A_BUNCH;
> >  		*my_list = realloc(*my_list, new_max_el * el_size);
> >  		if (! *my_list)
> > -			sensors_fatal_error("sensors_add_array_els",
> > +			sensors_fatal_error(__func__,
> >  					    "Allocating new elements");
> >  		*max_el = new_max_el;
> >  	}
> 

Andre
 
> -- 
> Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
