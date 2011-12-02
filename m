From: Charles <c@catcons.co.uk>
Date: Fri, 02 Dec 2011 06:43:59 +0000
Subject: Re: [lm-sensors] How to get patches and build with them?
Message-Id: <4ED870DF.3030605@catcons.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <4ED7B66A.6030009@catcons.co.uk>
In-Reply-To: <4ED7B66A.6030009@catcons.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 01/12/11 22:59, Jean Delvare wrote:
> Hi Charles,
> 
> On Thu, 01 Dec 2011 22:46:26 +0530, Charles wrote:
>> Hello :-)
>>
>> I want to build lm_sensors *3.3.1 *and see from
>> http://www.lm-sensors.org/wiki/Download that four patches are
>> recommended.  How do I download the patches and incorporate them during
>> the build?
> 
> Click each link, then scroll to the bottom of the page and choose
> "Unified Diff". I then recommend running dos2unix on all patches as for
> some strange reason trac produces DOS format text files. Then just
> apply the patches in order with patch -p2.
> 
> I'll let you appreciate which of these patches you actually want. I'm
> the one making the selection but it's often arbitrary and every case is
> different.
> 
>> I appreciate this is a common procedure and there must be some
>> instructions somewhere; a link to instructions would be helpful.
> 
> It's no so common, I think. The list of patches is mainly there for
> packagers. End-users are supposed to simply install packages from their
> distribution. As a matter of fact, I think you're the first one asking
> for help with this since I started maintaining this list 4 years ago.

Many thanks for the prompt reply Jean :)

I went with your recommended patches for starters.  Had to use -p3 (not
in expected directory?).  The build is for Slackware64 13.1, upgraded to
kernel 2.6.38.7 running on an ASUS PBH67-V motherboard which has a
Nuvoton NCT6776F -- as the newly installed lm_sensors 3.3.1
sensors-detect now reports :)

These are the download and patch commands used:

gpg --keyserver wwwkeys.pgp.net --recv-keys 38F02FC8

cd /tmp \
  && rm -fr lm_sensors-3.3.1 \
  && wget
http://dl.lm-sensors.org/lm-sensors/releases/lm_sensors-3.3.1.tar.bz2 \
  && wget
http://dl.lm-sensors.org/lm-sensors/releases/lm_sensors-3.3.1.tar.bz2.sig \
  && gpg --verify lm_sensors-3.3.1.tar.bz2.sig \
  && tar -jxvf lm_sensors-3.3.1.tar.bz2 \
  && cd lm_sensors-3.3.1 \
  && wget --output-document=patch_5991 \
    'http://www.lm-sensors.org/changeset/5991?format=diff&newY91' \
  && wget --output-document=patch_5992 \
    'http://www.lm-sensors.org/changeset/5992?format=diff&newY92' \
  && wget --output-document=patch_5993 \
    'http://www.lm-sensors.org/changeset/5993?format=diff&newY93' \
  && wget --output-document=patch_5999 \
    'http://www.lm-sensors.org/changeset/5999?format=diff&newY99' \
  && patch -p3 < patch_5991 \
  && patch -p3 < patch_5992 \
  && patch -p3 < patch_5993 \
  && patch -p3 < patch_5999

BTW, make PREFIX=/tmp/tmp installed to /usr/local

After installing to /usr/local the following symlink was required to
allow GKrellM to start:

ln -s /usr/local/lib/libsensors.so.4 /usr/lib64/libsensors.so.4

Best

Charles



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
