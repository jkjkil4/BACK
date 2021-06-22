function scrGetMenuChildX(_oid) { return _oid.x + _oid.maxWidth() * _oid.scale + 20; }
function scrGetMenuChildY(_oid, _index) { return _oid.y + _oid.tabY(_index); }