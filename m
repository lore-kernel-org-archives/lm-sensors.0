From: Karl Schmidt <karl@xtronics.com>
Date: Mon, 07 Sep 2009 19:08:05 +0000
Subject: Re: [lm-sensors] Creating alarm for fans
Message-Id: <4AA55A15.30604@xtronics.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4A9823A2.2010907@xtronics.com>
In-Reply-To: <4A9823A2.2010907@xtronics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

I sure wish there was a way to search for older postings of this mailing li=
st.  I think there may be=20
some ongoing work on the k8temp?



Running

#sensors
k8temp-pci-00c3
Adapter: PCI adapter
temp1:       +21.0=B0C


Trying to create an alarm for that temp:

#AMD K8 core temperature monitor
chip "k8temp-pci-00c3"
set temp1_max 10

But I get this:

# sensors -s
Error: Line 3: Unknown feature name
k8temp-pci-00c3: No such sub-feature known



---------------------------------------------------------------------------=
-----
Karl Schmidt                                  EMail Karl@xtronics.com
Transtronics, Inc.                              WEB http://xtronics.com
3209 West 9th Street                             Ph (785) 841-3089
Lawrence, KS 66049                              FAX (785) 841-0434

Action speaks louder than words but not nearly as often. -- Mark Twain

---------------------------------------------------------------------------=
-----

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
