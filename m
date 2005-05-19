From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:15 +0000
Subject: [PATCH 2.6] Update Documentation/i2c/writing-clients
Message-Id: <20040914175343.GA27024@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040913224113.0f3b15a4.khali@linux-fr.org>
In-Reply-To: <20040913224113.0f3b15a4.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Sep 13, 2004 at 10:41:13PM +0200, Jean Delvare wrote:
> Hi Greg,
> 
> This is a very small an update to Documentation/i2c/writing-clients. The
> changes are about i2c client driver ID. It used to say that chip driver
> writers should ask for a unique ID. It now explains that such an ID is
> not required and they can go without it. Until we get plain rid of it...
> 
> The patch additionally features CodingStyle updates. We can't ask people
> to respect it and at the same time ignore it in our own docs.
> 
> I have made a similar change to the i2c (the project) documentation, and
> will propose an update to Marcelo for Linux 2.4 (not sure he will accept
> it though).
> 
> Please apply,

Applied, thanks.

greg k-h
