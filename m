From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:45 +0000
Subject: RFC PATCH sensors-detect (was Re: tickets needing help)
Message-Id: <1078308010.4045acaa3c44f@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040303051957.GB9922@earth.solarsys.private>
In-Reply-To: <20040303051957.GB9922@earth.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Quoting "Mark M. Hoffman" <mhoffman@lightlink.com>:

> A couple months ago, I wrote...

I think I remember I was supposed to help... :/

> I still don't like perl much, but here's a patch/RFC.  It's not at
> all complete: I'd just like a second opinion on %pci_refs.  The
> idea is that we'll be able to do this:
> 
> 	if (exists $pci_refs{"1039:0645"}) { ... }
> 
> In fact, I think @pci_list should have been a hash of references
> instead of an array.  Could it be that sensors-detect is old enough
> to predate perl5?

I doubt it. Perl 5 was available for more than 4 full years as the
sensors-detect script was created.

More liekly, Frodo was not used to hashes (little people are before
they
really start feeling how powerful it is) and would not take care of
algoritmic complexity in his choices. That said, it worked for 4 years,
so it must not have been that bad.

> Oh, and there's a kernel version function too.  Comments?
> (...)
> -use vars qw(@pci_list);
> +use vars qw(@pci_list %pci_refs);

Why not simply "convert" the old list into the hash, instead of having
two variables? You can always get a list from a hash using the "values"
perl function.

Once done, we may find that in various places, we are walking the list
when we could use "exists" instead, and we will be able to optimize
this. I guess this was your intention anyway. Can you point us to the
particular places where such changes could be done?

> +sub kernel_version
> +{
> +  `uname -r` =~ /([0-9]+)\.([0-9]+)\.([0-9]+)(.*)/;
> +  return ($1, $2, $3, $4);
> +}

I'd prefer /^(\d+)\.(\d+)\.(\d+)(.*)/ as the regular expression. BTW,
do
we really need the fourth field? I don't much see what we will be doing
with it, since it's mostly distributor-dependant.

Also, I don't think this should be a function. Instead, I'd define a
global variable (an array, obviously) and  fill it at the beginning of
the script.

We may need functions, on the other hand, for version comparisons.
Something as "if (kernel_at_least(2,5,75)) { ... }". The function could
look like:

sub kernel_at_least
{
  my ($maj, $min, $rev) = @_;
  return 1 if $kver[0] > $maj ||
    ($kver[0] = maj && ($kver[1] > $min ||
      ($kver[1] = $min && $kver[2] >= $rev)));
  return 0;
}

(where @kver is the global array containing the kernel version
information).

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
