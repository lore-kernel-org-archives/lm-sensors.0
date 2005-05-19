From: sam@ravnborg.org (Sam Ravnborg)
Date: Thu, 19 May 2005 06:25:01 +0000
Subject: Finding user/kernel pointer bugs [no html]
Message-Id: <20040610202803.GA3673@mars.ravnborg.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1086838266.32059.320.camel@dooby.cs.berkeley.edu> <20040610044903.GE12308@parcelfarce.linux.theplanet.co.uk> <20040610165821.GB32577@kroah.com> <20040610191004.GA1661@kroah.com> <20040610191359.GJ12308@parcelfarce.linux.theplanet.co.uk> <20040610193207.GA1904@kroah.com>
In-Reply-To: <20040610193207.GA1904@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>
Cc: viro@parcelfarce.linux.theplanet.co.uk, sensors@stimpy.netroedge.com, "Robert T. Johnson" <rtjohnso@eecs.berkeley.edu>, Linux Kernel <linux-kernel@vger.kernel.org>

On Thu, Jun 10, 2004 at 12:32:08PM -0700, Greg KH wrote:
> On Thu, Jun 10, 2004 at 08:14:00PM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
> > On Thu, Jun 10, 2004 at 12:10:04PM -0700, Greg KH wrote:
> > > @@ -170,8 +170,11 @@
> > >  static int DIV_TO_REG(int val)
> > >  {
> > >  	int answer = 0;
> > > -	while ((val >>= 1))
> > > +	val >>= 1;
> > > +	while (val) {
> > >  		answer++;
> > > +		val >>= 1;
> > > +	}
> > >  	return answer;
> > 
> > That's less readable than the original...
> 
> Hm, so we should ignore the sparse warning about the original then?

What about:

	while ((val >>= 1) != 0) {
		...

Readable and sparse clean (I suppose).

	Sam
