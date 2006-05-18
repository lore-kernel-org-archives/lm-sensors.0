From: bezaur@gmail.com (Charles Spirakis)
Date: Thu, 18 May 2006 22:52:32 +0000
Subject: [lm-sensors] sensors-detect: Update sensors-detect to handle
Message-Id: <5bfe43f80605181552m1ae3ee6bqca9d42f8c2b2eeff@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <5bfe43f80604261454g6c48e2a3o926d5a783976563f@mail.gmail.com>
In-Reply-To: <5bfe43f80604261454g6c48e2a3o926d5a783976563f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Sounds good.

I will clean up option 1 and submit an official patch.

And yes, I'd be happy to be the maintainer for the 83791d. Do I submit
the patch for that here or someplace else?

Thanks!

-- charles


On 5/15/06, Jean Delvare <khali at linux-fr.org> wrote:
> Hi Charles,
>
> I'm very sorry for the late answer, I had forgotten about this post.
>
> > To handle the 2.4/2.6 different for the SiS adapter, there are extra
> > sis elements (@pci_adapters_sis5595 @pci_adapters_sis645
> > @pci_adapters_sis96x ~ line 844) and a new routine
> > (adapter_pci_detection_sis_96x() ~ line 2134) which then pushes one or
> > more of the new elements onto the @pci_adapters list as needed (called
> > ~ line 2183). Line numbers are based on sensors-detect perl script
> > from the lm-sensors package version 2.10.0.
> >
> > Since the w83781d is part of the @chip_ids list and not part of the
> > @pci_adapters list (or checks), it seemed like trying to overuse the
> > sis subroutine may not make sense. Thus, there seemed to be three
> > choices for handling the w83791d:
> >
> > 1) Follow the general sis pattern and create two new entries for the
> > w83791d - one for the 2.4 kernel and one for the 2.6 kernel, then
> > create a routine to pushd the correct entry onto the @chip_ids list
> > (similar to what the SiS is doing for the adapter, but for chips).
> >
> > 2) Create a routine that walks the @chip_ids list and modifies
> > specific chip_id entries for earlier kernels as needed.
> >
> > 3) Special case the driver field to allow for a "driver-choice"
> > (similar to "to-be-written" and "not-a-sensor" that's available now).
> > When the "driver-choice" string is seen, then have a driver_choice
> > field (a new field in a chip element) point to a subroutine to give
> > you the actual driver name.
> >
> > 4) Other???
> >
> > I admit, Perl is not my native language so it's possible (4) is the
> > right answer. So, before submitting an "official" patch, I prototyped
> > choices (1) and (2) above and included them below for comment. If it's
> > easier, I can turn one (or both) into a real patch for people to
> > try...
> >
> > Preferences? Thoughts? Comments?
>
> My preference goes to option 1 because that's the way we handle the SiS
> SMBus case, and using the same mechanism everywhere will make it easier
> to the reader. Your proposed implementation looks OK, with the minor
> comments below:
>
> > --- sensors-detect.000  Tue Apr 25 11:20:26 2006
> > +++ sensors-detect      Wed Apr 26 14:37:30 2006
> > @@ -915,6 +915,24 @@
> >              w83791sd_detect vt1211_i2c_detect vt1211_alias_detect
> >              smsc47m192_detect);
> >
> > +# Special case chip information goes here and would be included in
> > +# the chip_special_cases routine below
> > +use vars qw($chip_ids_kern24_w83791d $chip_ids_kern26_w83791d);
>
> "ids" doesn't make much sense here.
>
> > +$chip_ids_kern24_w83791d = {
> > +       name => "Winbond W83791D",
> > +       driver => "w83781d",
> > +       i2c_addrs => [0x2c..0x2f],
> > +       i2c_detect => sub { w83781d_detect 7, @_},
>
> Add a space before the closing curly brace.
>
> > +};
> > +
> > +$chip_ids_kern26_w83791d = {
> > +       name => "Winbond W83791D",
> > +       driver => "w83791d",
> > +       i2c_addrs => [0x2c..0x2f],
> > +       i2c_detect => sub { w83781d_detect 7, @_},
> > +};
>
> Ditto.
>
> > +
> > +
> >  # This is a list of all recognized chips.
> >  # Each entry must have the following fields:
> >  #  name: The full chip name
> > @@ -1054,12 +1072,6 @@
> >         i2c_detect => sub { w83781d_detect 2, @_},
> >       } ,
> >       {
> > -       name => "Winbond W83791D",
> > -       driver => "w83781d",
> > -       i2c_addrs => [0x2c..0x2f],
> > -       i2c_detect => sub { w83781d_detect 7, @_},
> > -     },
> > -     {
> >         name => "Winbond W83792D",
> >         driver => "w83792d",
> >         i2c_addrs => [0x2c..0x2f],
> > @@ -2844,6 +2856,20 @@
> >  # this program will surely confuse them. But we guarantee never to write to
> >  # any of these devices.
> >
> > +# This routine allows you to select which chips are optionally added to the
> > +# chip detection list. The most common use is to allow for different chip
> > +# detection/drivers based on different linux kernels
> > +# This routine follows the pattern of the Sis adapter special cases
> > +sub chip_special_cases
> > +{
> > +  # Based on the kernel, add the appropriate chip structure to the
> > +  # chip_ids detection list
> > +  if (kernel_version_at_least(2,6,0)) {
> > +    push @chip_ids, $chip_ids_kern26_w83791d;
> > +  } elsif (kernel_version_at_least(2,4,0)) {
>
> This second test is not needed, a simple "else" would do (we do no more
> support kernels older than 2.4.10 anyway.)
>
> > +    push @chip_ids, $chip_ids_kern24_w83791d;
> > +  }
> > +}
> >
> >  # $_[0]: A reference to the file descriptor to access this chip.
> >  #        We may assume an i2c_set_slave_addr was already done.
> > @@ -5077,6 +5103,10 @@
> >      }
> >    }
> >
> > +  # Before looking for chips, make sure any special case chips are
> > +  # added to the chip_ids list
> > +  chip_special_cases();
> > +
> >    print "\n We are now going to do the adapter probings. Some adapters may ",
> >          "hang halfway\n",
> >          " through; we can't really help that. Also, some chips will be double ",
>
> I would also suggest that you place the w83791d entries after the array
> with all the other entries, rather than before (again to make it
> similar to what we did for the SiS case.)
>
> Care to submit a real patch for us to apply?
>
> Also, I can't remember if I asked you already... Would you mind
> becoming the maintainer for the driver you wrote/ported? It's
> convenient for me when individual drivers have a separate maintainer so
> as to lower my workload. If you accept, please send a patch adding an
> entry into MAINTAINERS (into alphabetical order.) You may take a look
> at the F71805F entry for an example.
>
> Thanks,
> --
> Jean Delvare
>

