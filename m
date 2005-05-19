From: steve@daviesfam.org (Stephen Davies)
Date: Thu, 19 May 2005 06:23:27 +0000
Subject: BT869 driver patch
Message-Id: <Pine.LNX.4.21.0201031905560.2759-100000@bob.daviesfam.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.21.0201031832260.2759-200000@bob.daviesfam.org>
In-Reply-To: <Pine.LNX.4.21.0201031832260.2759-200000@bob.daviesfam.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



On Thu, 3 Jan 2002 phil@netroedge.com wrote:

> Thanks for the submission.  The only piece right now that I'm not
> liking is that #define DO_720_576 and the later #ifdef.  Can we do
> away with these?  It's not clear what we gain with adding those in.
> Otherwise, I appreciate your work, and I'd like to incorporate your
> additions!


The define is only there by way of a way to leave it out.  Would you like
a new patch without that, or can you remove it yourself?

Steve
