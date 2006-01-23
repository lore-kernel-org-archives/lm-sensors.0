From: phil@edgedesign.us (Philip Edelbrock)
Date: Mon, 23 Jan 2006 02:55:06 +0000
Subject: [lm-sensors] move to new website - status?
Message-Id: <8888FA90-2644-4B0B-A523-9B9BD120CB11@edgedesign.us>
List-Id: <lm-sensors.vger.kernel.org>
References: <43D15E0D.1020309@sh.cvut.cz>
In-Reply-To: <43D15E0D.1020309@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


On Jan 21, 2006, at 1:47 AM, Rudolf Marek wrote:

>
> Phil, what about the ticket system conversion as Jean mentioned it?

Hi Rudolf and Jean, thanks for following up.

I've processed the old tickets and put them into the new trac schema  
for Axel.  I don't have write access to the trac database (which is  
fine), so I've done two things:

- I've uploaded a sql script which contains the old tickets into my  
home directory on the server.  It is called "old-tickets-trac.sql".   
It requires that there be a new component called 'legacy' so that we  
can keep these tickets apart from the new ones. (sql: insert into  
component values ('legacy','somebody','import from legacy ticket  
system'); )

- I've taken a copy of the current trac database (trac.db) and  
already added the new component and imported the tickets.  Again this  
db (still named trac.db) is in my home directory if you want to use  
that, Axel.

A couple notes:

- The SQL comes from a Perl script, so if it looks/works aweful, I  
can tweak the script as needed and run another dump.  I haven't see  
what this actually looks like in Trac yet, so if needed, we can try  
it again.

- The dates are the same on all the tickets.  If it is important to  
keep the dates, I can work on it some more.  Trac's schema uses an  
integer to store dates instead of datetime/timestamp types.

- For some reason tickets 125 and 126 didn't import.  We can just  
copy and paste those in.  Not bad considering there are over 2,000+  
tickets!


Phil


