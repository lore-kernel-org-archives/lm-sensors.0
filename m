From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 31 Oct 2007 20:08:37 +0000
Subject: Re: [lm-sensors] Utility for creating computate sensors.conf lines
Message-Id: <20071031210837.29f29516@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <472841C2.5060701@hhs.nl>
In-Reply-To: <472841C2.5060701@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Wed, 31 Oct 2007 09:50:10 +0100, Hans de Goede wrote:
> Hi all,
> 
> As discussed here is an utility for creating computate sensors.conf lines for 
> fscher and newer from DMI tables.
> 
> I wrote it in C as I'm most fluent in that language. I've it attached, shall I 
> import it somewhere under progs?

C is definitely not the language I would have chosen for the job, but
that's your tool so it's really up to you ;)

Yes, you should add this to the lm-sensors repository, either under etc
or create for example prog/config and put it there (in which case we
would move sensors-conf-convert there too.)

Please first convert the code to stick to the usual coding style, in
particular indent with tabs and opening curly braces go at the end of
the line.

You'll have to add a license statement and copyright at the top of the
file.

> #include <stdio.h>
> #include <unistd.h>
> #include <sys/types.h>
> 
> int main(void)
> {
>    char buf[512];
>    unsigned int x;
>    FILE *f;
>    int i, count, entities_found;;
>    int in0_mult, in1_mult, in2_mult, in0_offset, in1_offset, in2_offset, vref;
>    
>    if (getuid())
>    {
>       fprintf(stderr, "Error this program must be run as root because it "
>                       "invokes / uses dmidecode which requires root rights\n");
>       return 1;
>    }
>    
>    f = popen("/usr/sbin/dmidecode", "r");

You could use dmidecode's command line parameters to ease your parsing
work or at least speed it up. In particular, option -t, and maybe -u.

>    
>    if (!f)
>    {
>       perror("Error invoking dmidecode failed");
>       return 1;
>    }
>    
>    while (fgets(buf, sizeof(buf), f))
>    {
>       if (strcmp(buf, "OEM-specific Type\n"))
>          continue;
> 
>       if (!fgets(buf, sizeof(buf), f))
>          break;
> 
>       if (strcmp(buf, "\tHeader and Data:\n"))
>          continue;
> 
>       count = 0;
>       entities_found = 0;
>       
>       while (fscanf(f, "%x", &x) = 1)
>       {
>          buf[count] = x;
>          count++;
>       }
> 
>       /* we are looking for what Siemens calls "subtype" 19, the subtype
>          is stored in byte 5 of the dmi block */
>       if (buf[4] != 19)
>          continue;
>          
>       /* After the subtype comes 1 unknown byte and then blocks of 5 bytes,
>          consisting of what Siemens calls an "Entity" number, followed by
>          2 16 bit words in LSB first order */
>       for (i = 6; (i + 4) < count; i += 5)
>       {
>          if (buf[i] = 1) /* entity 1 5 volt / in1 multiplier and offset */
>          {
>             in1_mult   = buf[i + 1] | (buf[i + 2] << 8);
>             in1_offset = buf[i + 3] | (buf[i + 4] << 8);
>             entities_found += 0x0001;
>          }
>          if (buf[i] = 2) /* entity 2 12 volt / in0 multiplier and offset */
>          {
>             in0_mult   = buf[i + 1] | (buf[i + 2] << 8);
>             in0_offset = buf[i + 3] | (buf[i + 4] << 8);
>             entities_found += 0x0010;
>          }
>          if (buf[i] = 3) /* entity 3 vbat / in2 multiplier and offset */
>          {
>             in2_mult   = buf[i + 1] | (buf[i + 2] << 8);
>             in2_offset = buf[i + 3] | (buf[i + 4] << 8);
>             entities_found += 0x0100;
>          }

Looks to me like these 3 first cases could be refactored easily if you
had arrays instead of separate variables for in*_mult and in*_offset.

>          if (buf[i] = 7) /* entity 7 reference voltage */
>          {
>             vref = buf[i + 1] | (buf[i + 2] << 8);
>             entities_found += 0x1000;
>          }

The "+="s above should IMHO be "|="s. Granted, it only makes a
difference if the same entity is described twice, which shouldn't
happen, but I still think it's cleaner that way.

>          
>       }
>       
>       if (entities_found = 0x1111)
>       {
>          printf("    compute in0       (@ * (%d * %d) / 255) + (%d * 10), (@ - (%d * 10)) * 255 / (%d * %d)\n",
>             in0_mult, vref, in0_offset, in0_offset, in0_mult, vref);
>          printf("    compute in1       (@ * (%d * %d) / 255) + (%d * 10), (@ - (%d * 10)) * 255 / (%d * %d)\n",
>             in1_mult, vref, in1_offset, in1_offset, in1_mult, vref);
>          printf("    compute in2       (@ * (%d * %d) / 255) + (%d * 10), (@ - (%d * 10)) * 255 / (%d * %d)\n",
>             in2_mult, vref, in2_offset, in2_offset, in2_mult, vref);
>          fclose(f);
>          return 0;
>       }

I'd suggest adding a condition "entities_found != 0x1111" to your while
statement above, so that you can move the printing code out of the loop.

>    }
>    
>    fclose(f);
> 

Maybe print an error message if you failed to generate the compute
lines?

>    return 0;
> }


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
