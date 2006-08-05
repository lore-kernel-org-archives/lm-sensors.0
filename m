From: yani.ioannou@gmail.com (Yani Ioannou)
Date: Sat, 05 Aug 2006 10:12:46 +0000
Subject: [lm-sensors] Adding userspace support for ipmisensors
Message-Id: <253818670608050312h1d6387f5ud6bf51b2ae07ad65@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <253818670608031201l3e101782r5d1012900ddecdf8@mail.gmail.com>
In-Reply-To: <253818670608031201l3e101782r5d1012900ddecdf8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 8/4/06, Yani Ioannou <yani.ioannou at gmail.com> wrote:
> Hi Jean,
>
> On 8/4/06, Jean Delvare <khali at linux-fr.org> wrote:
> > We can obviously apply this, it's not very intrusive ;) However, may I
> > ask why you didn't simply keep the "bmc" prefix? You would have won
> > compatibility with a few previous releases of lm_sensors, and the name
> > change might also confuse the users.

Actually just letting the name attribute return "bmc" seems to allow
ipmisensors to work with lm-sensors as is (with the exception of
sensors-detect as mentioned before). So I think thats the way I'll go
for now.

Yani

