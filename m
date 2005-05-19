From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:23:49 +0000
Subject: Is this a bug in i2c-philips-par.c?
Message-Id: <3E6A7114.70207@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200302232023.40175.dpnsw@optusnet.com.au>
In-Reply-To: <200302232023.40175.dpnsw@optusnet.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

- it does not appear to be a bug;
- the code has been rewritten in CVS anyway

David wrote:
> Can someone check if this is a bug and apply diff as necessary.
> 
> Looks like it would only affect people of kernels prior to 2.3.4
> 
> Normal cavets apply.
> 
> 1)	I am not a programmer
> 2)	I barely know C
> 3)	Consider yourself warned.
> 
> Thanks
> 
> 
> ------------------------------------------------------------------------
> 
> 289,290c289,290
> < 	for (port = parport_enumerate(); port; port=port->next)
> < 		i2c_parport_detach(port);
> ---
> 
>>	for (port = parport_enumerate(); port; port=port->next);
>>	i2c_parport_detach(port);
