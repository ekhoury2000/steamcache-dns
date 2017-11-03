#!/bin/sh

# if [ -n "$STEAMCACHE_RESOLVE_NAME" ]
# then
# 	RESOLVED_IP="$(nslookup "$STEAMCACHE_RESOLVE_NAME" 2>/dev/null | grep 'Address' | awk '{ print $3 }')"
# 	if [ -n "$RESOLVED_IP" ]
# 	then
# 		echo "Resolved ${STEAMCACHE_RESOLVE_NAME} to ${RESOLVED_IP}"
# 		STEAMCACHE_IP="$RESOLVED_IP"
# 	else
# 		echo "Failed to resolve ${STEAMCACHE_RESOLVE_NAME}; using ${STEAMCACHE_IP} instead" >&2
# 	fi
# fi

# if [ -z "$STEAMCACHE_IP" ]
# then
# 	echo "No value in \$STEAMCACHE_IP!" >&2
# 	exit 1
# fi

echo "Running bootstrap.sh..."

if [ "$USE_GENERIC_CACHE" = "true" ]; then
	# We will use the generic cache IP for anything that is not defined.

	if [ -z "$LANCACHE_IP" ]; then
		echo "USE_GENERIC_CACHE is true but LANCACHE_IP is not set. Ignoring Generic Cache"
	else
		if [ -z "$BLIZZARDCACHE_IP" ] && ! [ "$DISABLE_BLIZZARD" = "true" ]; then
			BLIZZARDCACHE_IP=$LANCACHE_IP
		fi
		if [ -z "$FRONTIERCACHE_IP" ] && ! [ "$DISABLE_FRONTIER" = "true" ]; then
			FRONTIERCACHE_IP=$LANCACHE_IP
		fi
		if [ -z "$ORIGINCACHE_IP" ] && ! [ "$DISABLE_ORIGIN" = "true" ]; then
			ORIGINCACHE_IP=$LANCACHE_IP
		fi
		if [ -z "$RIOTCACHE_IP" ] && ! [ "$DISABLE_RIOT" = "true" ]; then
			RIOTCACHE_IP=$LANCACHE_IP
		fi
		if [ -z "$STEAMCACHE_IP" ] && ! [ "$DISABLE_STEAM" = "true" ]; then
			STEAMCACHE_IP=$LANCACHE_IP
		fi
		if [ -z "$UPLAYCACHE_IP" ] && ! [ "$DISABLE_UPLAY" = "true" ]; then
			UPLAYCACHE_IP=$LANCACHE_IP
		fi
		if [ -z "$WINDOWSCACHE_IP" ] && ! [ "$DISABLE_WINDOWS" = "true" ]; then
			WINDOWSCACHE_IP=$LANCACHE_IP
		fi
		if [ -z "$HIREZCACHE_IP" ] && ! [ "$DISABLE_HIREZ" = "true" ]; then
			HIREZCACHE_IP=$LANCACHE_IP
		fi
		if [ -z "$SONYCACHE_IP" ] && ! [ "$DISABLE_SONY" = "true" ]; then
			SONYCACHE_IP=$LANCACHE_IP
		fi
		if [ -z "$TERACACHE_IP" ] && ! [ "$DISABLE_TERA" = "true" ]; then
			TERACACHE_IP=$LANCACHE_IP
		fi
		if [ -z "$GOGCACHE_IP" ] && ! [ "$DISABLE_GOG" = "true" ]; then
			GOGCACHE_IP=$LANCACHE_IP
		fi
		if [ -z "$ARENACACHE_IP" ] && ! [ "$DISABLE_ARENA" = "true" ]; then
			ARENACACHE_IP=$LANCACHE_IP
		fi
		if [ -z "$APPLECACHE_IP" ] && ! [ "$DISABLE_APPLE" = "true" ]; then
			APPLECACHE_IP=$LANCACHE_IP
		fi
		if [ -z "$WARGAMINGCACHE_IP" ] && ! [ "$DISABLE_WARGAMING" = "true" ]; then
			WARGAMINGCACHE_IP=$LANCACHE_IP
		fi
		if [ -z "$GLYPHCACHE_IP" ] && ! [ "$DISABLE_GLYPH" = "true" ]; then
			GLYPHCACHE_IP=$LANCACHE_IP
		fi
	fi
fi

## blizzard
if ! [ -z "$BLIZZARDCACHE_IP" ]; then
	echo "Enabling cache for Blizzard"
	cp /etc/bind/cache/blizzard/template.db.blizzard /etc/bind/cache/blizzard/db.blizzard
	sed -i -e "s%{{ blizzardcache_ip }}%$BLIZZARDCACHE_IP%g" /etc/bind/cache/blizzard/db.blizzard
	sed -i -e "s%#ENABLE_BLIZZARD#%%g" /etc/bind/cache.conf
fi

## frontier
if ! [ -z "$FRONTIERCACHE_IP" ]; then
	echo "Enabling cache for Frontier"
	cp /etc/bind/cache/frontier/template.db.frontier /etc/bind/cache/frontier/db.frontier
	sed -i -e "s%{{ frontiercache_ip }}%$FRONTIERCACHE_IP%g" /etc/bind/cache/frontier/db.frontier
	sed -i -e "s%#ENABLE_FRONTIER#%%g" /etc/bind/cache.conf
fi

## origin
if ! [ -z "$ORIGINCACHE_IP" ]; then
	echo "Enabling cache for Origin"
	cp /etc/bind/cache/origin/template.db.origin /etc/bind/cache/origin/db.origin
	sed -i -e "s%{{ origincache_ip }}%$ORIGINCACHE_IP%g" /etc/bind/cache/origin/db.origin
	sed -i -e "s%#ENABLE_ORIGIN#%%g" /etc/bind/cache.conf
fi

## riot
if ! [ -z "$RIOTCACHE_IP" ]; then
	echo "Enabling cache for Riot"
	cp /etc/bind/cache/riot/template.db.riot /etc/bind/cache/riot/db.riot
	sed -i -e "s%{{ riotcache_ip }}%$RIOTCACHE_IP%g" /etc/bind/cache/riot/db.riot
	sed -i -e "s%#ENABLE_RIOT#%%g" /etc/bind/cache.conf
fi

## steam
if ! [ -z "$STEAMCACHE_IP" ]; then
	echo "Enabling cache for Steam"
	cp /etc/bind/cache/steam/template.db.content_.steampowered.com /etc/bind/cache/steam/db.content_.steampowered.com
	cp /etc/bind/cache/steam/template.db.cs.steampowered.com /etc/bind/cache/steam/db.cs.steampowered.com
	cp /etc/bind/cache/steam/template.db.steamcontent.com /etc/bind/cache/steam/db.steamcontent.com
	sed -i -e "s%{{ steamcache_ip }}%$STEAMCACHE_IP%g" /etc/bind/cache/steam/db.content_.steampowered.com
	sed -i -e "s%{{ steamcache_ip }}%$STEAMCACHE_IP%g" /etc/bind/cache/steam/db.cs.steampowered.com
	sed -i -e "s%{{ steamcache_ip }}%$STEAMCACHE_IP%g" /etc/bind/cache/steam/db.steamcontent.com
	sed -i -e "s%#ENABLE_STEAM#%%g" /etc/bind/cache.conf
fi

## uplay
if ! [ -z "$UPLAYCACHE_IP" ]; then
	echo "Enabling cache for Uplay"
	cp /etc/bind/cache/uplay/template.db.uplay /etc/bind/cache/uplay/db.uplay
	sed -i -e "s%{{ uplaycache_ip }}%$UPLAYCACHE_IP%g" /etc/bind/cache/uplay/db.uplay
	sed -i -e "s%#ENABLE_UPLAY#%%g" /etc/bind/cache.conf
fi

## Hirez
if ! [ -z "$HIREZCACHE_IP" ]; then
	echo "Enabling cache for Hirez"
	cp /etc/bind/cache/hirez/template.db.hirez /etc/bind/cache/hirez/db.hirez
	sed -i -e "s%{{ hirezcache_ip }}%$HIREZCACHE_IP%g" /etc/bind/cache/hirez/db.hirez
	sed -i -e "s%#ENABLE_HIREZ#%%g" /etc/bind/cache.conf
fi

## Sony
if ! [ -z "$SONYCACHE_IP" ]; then
	echo "Enabling cache for Sony"
	cp /etc/bind/cache/sony/template.db.sony /etc/bind/cache/sony/db.sony
	sed -i -e "s%{{ sonycache_ip }}%$SONYCACHE_IP%g" /etc/bind/cache/sony/db.sony
	sed -i -e "s%#ENABLE_SONY#%%g" /etc/bind/cache.conf
fi


## Tera
if ! [ -z "$TERACACHE_IP" ]; then
	echo "Enabling cache for Tera"
	cp /etc/bind/cache/tera/template.db.tera /etc/bind/cache/tera/db.tera
	sed -i -e "s%{{ teracache_ip }}%$TERACACHE_IP%g" /etc/bind/cache/tera/db.tera
	sed -i -e "s%#ENABLE_TERA#%%g" /etc/bind/cache.conf
fi


## windows
if ! [ -z "$WINDOWSCACHE_IP" ]; then
	echo "Enabling cache for Windows"
	cp /etc/bind/cache/windows/template.db.windows /etc/bind/cache/windows/db.windows
	sed -i -e "s%{{ windowscache_ip }}%$WINDOWSCACHE_IP%g" /etc/bind/cache/windows/db.windows
	sed -i -e "s%#ENABLE_WINDOWS#%%g" /etc/bind/cache.conf
fi


## GOG
if ! [ -z "$GOGCACHE_IP" ]; then
	echo "Enabling cache for GOG"
	cp /etc/bind/cache/gog/template.db.gog /etc/bind/cache/gog/db.gog
	sed -i -e "s%{{ gogcache_ip }}%$GOGCACHE_IP%g" /etc/bind/cache/gog/db.gog
	sed -i -e "s%#ENABLE_GOG#%%g" /etc/bind/cache.conf
fi

## Arena
if ! [ -z "$ARENACACHE_IP" ]; then
	echo "Enabling cache for Arena"
	cp /etc/bind/cache/arena/template.db.arena /etc/bind/cache/arena/db.arena
	sed -i -e "s%{{ arenacache_ip }}%$ARENACACHE_IP%g" /etc/bind/cache/arena/db.arena
	sed -i -e "s%#ENABLE_ARENA#%%g" /etc/bind/cache.conf
fi

## Apple
if ! [ -z "$APPLECACHE_IP" ]; then
	echo "Enabling cache for Apple"
	cp /etc/bind/cache/apple/template.db.apple /etc/bind/cache/apple/db.apple
	sed -i -e "s%{{ applecache_ip }}%$APPLECACHE_IP%g" /etc/bind/cache/apple/db.apple
	sed -i -e "s%#ENABLE_APPLE#%%g" /etc/bind/cache.conf
fi

## Wargaming
if ! [ -z "$WARGAMINGCACHE_IP" ]; then
	echo "Enabling cache for Wargaming"
	cp /etc/bind/cache/wargaming/template.db.wargaming /etc/bind/cache/wargaming/db.wargaming
	sed -i -e "s%{{ wargamingcache_ip }}%$WARGAMINGCACHE_IP%g" /etc/bind/cache/wargaming/db.wargaming
	sed -i -e "s%#ENABLE_WARGAMING#%%g" /etc/bind/cache.conf
fi

## Glyph
if ! [ -z "$GLYPHCACHE_IP" ]; then
	echo "Enabling cache for Glyph"
	cp /etc/bind/cache/glyph/template.db.glyph /etc/bind/cache/glyph/db.glyph
	sed -i -e "s%{{ glyphcache_ip }}%$GLYPHCACHE_IP%g" /etc/bind/cache/glyph/db.glyph
	sed -i -e "s%#ENABLE_GLYPH#%%g" /etc/bind/cache.conf
fi

echo "bootstrap finished."

echo "checking Bind9 config"

if ! /usr/sbin/named-checkconf /etc/bind/named.conf ; then
	echo "Problem with Bind9 configuration - Bailing" >&2
	exit 1
fi

echo "Running Bind9"

/usr/sbin/named -u named -c /etc/bind/named.conf -f
BEC=$?

if ! [ $BEC = 0 ]; then
	echo "Bind9 exited with ${BEC}"
	exit ${BEC} #exit with the same exit code as bind9
fi
