From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 19 Oct 2010 18:12:13 +0000
Subject: Re: [lm-sensors] [PATCH] lm-sensors: Fix error seen with
Message-Id: <20101019181213.GB31594@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101019191020.3063dc92@endymion.delvare>
In-Reply-To: <20101019191020.3063dc92@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Oct 19, 2010 at 01:10:20PM -0400, Jean Delvare wrote:
> Hi Guenter,
> 
> On Tue, 19 Oct 2010 09:48:19 -0700, Guenter Roeck wrote:
> > The following patch fixes an error seen in sensors-detect if i2c bus numbering
> > is not sequential. Problem is that in this case, $i2c_adapters[] does not exist
> > for all index values, causing an error message whenever one of the non-existing 
> > objects is accessed.
> > 
> > The error message is:
> > 	Use of uninitialized value in string eq at ./sensors-detect line 5941.
> > 
> > Index: prog/detect/sensors-detect
> > =================================> > --- prog/detect/sensors-detect	(revision 5868)
> > +++ prog/detect/sensors-detect	(working copy)
> > @@ -5936,7 +5936,9 @@
> >  	# If we added any module option to handle aliases, we need to load all
> >  	# the adapter drivers so that the numbers will be the same. If not, then
> >  	# we only load the adapter drivers which are useful.
> > -	foreach $adap (@i2c_adapters) {
> > +	for (my $dev_nr = 0; $dev_nr < @i2c_adapters; $dev_nr++) {
> > +		next unless exists $i2c_adapters[$dev_nr];
> > +		$adap = $i2c_adapters[$dev_nr];
> >  		next if $adap->{autoload};
> >  		next if $adap->{driver} eq 'UNKNOWN';
> >  		next if not defined $configfile and not $adap->{used};
> 
> Good catch, but what's wrong with foreach? I believe you can just add:
> 
> 		next unless defined $adap;
> 
You are right, that works as well, and is simpler. Only reason for using for
instead of foreach was that the for loop was used elsewhere already.

I'll change it and resubmit.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
