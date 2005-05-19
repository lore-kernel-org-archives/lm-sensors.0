From: perrye@linuxmail.org (Perry Gilfillan)
Date: Thu, 19 May 2005 06:24:43 +0000
Subject: Acquiring an i2c adapter.
Message-Id: <40394258.6050303@linuxmail.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4037FB21.20701@linuxmail.org>
In-Reply-To: <4037FB21.20701@linuxmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
>>We've been wondering over here at sensors what the point was of unique
>>IDs. nobody seemed to use them.
> 
> 
> I think we have to make a difference between adapters and chips here. It
> looks quite obvious that adapters' IDs may have a use (as this is the
> case now). What I think Greg was suggesting is that we could drop IDs of
> _chip_ drivers, because those will hardly ever get used.
> 

While the i2c_clients_command function does not use the id, in the v3tv 
module I have a function voodoo3_call_i2c_client (very bottom of 
/v3tv/voodoo-i2c.c) that does use it.

The i2c_clients_command pass the command along to any client on the 
adapter that has a driver->command.  With my version, only the client of 
interest gets the call.

There are two sides to this.  On one hand, if a client would respond to 
a given command, but I don't want it to, I can exclude it.

On the other hand, using i2c_clients_command, if I want all clients to 
recieve the command, one call to i2c_clients_command will suffice.

Any way, the change from voodoo3_call_i2c_client to i2c_clients_command 
is a trivial one for me to make, I've considered it before, therefore 
driver id's are not critical to me.

Cheers,

Perry
-----
V3TV: http://gilfillan.org:8000/v3tv/
VPX3224: http://gilfillan.org:8000/vpx3224/

