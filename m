From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 03 Mar 2006 08:53:12 +0000
Subject: [lm-sensors] Need help, all temps are displaying -48.0C
Message-Id: <Nxc0TUk9.1141375992.2551700.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060302041617.7762.qmail@web32514.mail.mud.yahoo.com>
In-Reply-To: <20060302041617.7762.qmail@web32514.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Pat,

Please always reply to the list rather than to me only. Others may be
able to help you too.

On 2006-03-02, Pat wrote:
> > > [root at localhost ~]# sensors-detect
> > > Hexadecimal number > 0xffffffff non-portable at
> > > /usr/local/sbin/sensors-detect l ine 2108, <INPUTFILE> line 15.
> > > # sensors-detect revision 1.413 (2006/01/19 20:28:00)
> >
> > Hm, this is an odd error message, I've never seen it
> > before. Can you please provide the contents of your
> > /proc/bus/pci/devices file? I don't think this is related to your
> > problem, but let's fix the error if we can.
>
> I have attached the file.

OK, indeed you have a value in there which doesn't fit on 32 bits, which
isn't that surprising on a 64-bit system, I guess, but for some reason
perl feels like it should warn about it.

Can you please try to replace, in function read_proc_dev_pci of
sensors-detect,
  oct "0x$_"
by
  hex
. It should produce the same result, but maybe we'll go round the
warning.

If not, we may try to read less values from /proc/bus/pci/devices, as we
currently read many values we don't need anyway.

Thanks,
--
Jean Delvare

