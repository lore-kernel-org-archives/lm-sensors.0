From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 20 Feb 2008 08:21:01 +0000
Subject: Re: [lm-sensors] adt7475 support status update?
Message-Id: <20080220092101.55386587@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <47B32CEF.40405@hhs.nl>
In-Reply-To: <47B32CEF.40405@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Matt,

On Tue, 19 Feb 2008 22:24:02 -0600 (CST), Matt Roberds wrote:
> On Tue, 19 Feb 2008, Jordan Crouse wrote:
> > Updated patch against HEAD is attached.
> > [...]
> >+/* 7475 Notes:
> >+ * Addeded by: Jordan Crouse <jordan.crouse@amd.com>
> >+ * Datasheet:  http://www.analog.com/UploadedFiles/Data_Sheets/ADT7475.=
pdf
> >+ * TODO:  enhanced acoustics
> >+ */
>=20
> This doesn't affect the code at all, but this line of chips was
> apparently sold to On Semiconductor, effective 1 Jan 2008.  When I was
> looking for data on this chip in mid-January, Analog Devices no longer
> had the data sheet and On hadn't posted it yet, but now it is available
> from On.  Product page is
> http://www.onsemi.com/PowerSolutions/product.do?id=ADT7475 and datasheet
> is http://www.onsemi.com/pub/Collateral/ADT7475-D.PDF .  This seems to
> have affected several of the ADT74xx series chips.

Thanks for the information. I have updated wiki/Devices to reflect this
change for the ADT7475.

I fear that this change will affect pretty much all the hardware
monitoring chips originally designed and sold by Analog Devices. Even
the old ADM1022, ADM1024, ADM1026, ADM1027 etc. have been removed from
the Analog Devices website. These 3 pages on the ON Semiconductor
website seem to cover pretty much all the hardware monitoring chips of
Analog Devices:
  http://www.onsemi.com/PowerSolutions/parametrics.do?id!27
  http://www.onsemi.com/PowerSolutions/parametrics.do?id!26
  http://www.onsemi.com/PowerSolutions/parametrics.do?id!25

We will have to update all the links on the wiki/Devices pages, and
ideally we would also update the references in the source code of all
related drivers. This is a non-trivial amount of work, volunteers are
welcome.

Thanks,
--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
