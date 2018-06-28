/**
 * 하이웍스 조직도 트리
 *
 * @todo       범용 트리 모델로 개발
 * @category   Hiworks
 * @package    Hiworks_Organization
 * @version    1.0
 * @since      2010-04-17
 * @author     Nios <sjy@>
 * @update	   jhkim jquery use
 */


var OrgTree = function()
{
	this._display_manager = false;      // 관리 기능 표시 여부
	this._prefix_node = 'OrgTreeNode';  // 트리 노드의 고유 ID 접두사
	this._prefix_func =  'OrgTreeFunc'; // 관리 노드의 고유 ID 접두사
	this._root_node = null;            // 노드 루트 객체
	this._root_func = null;            // 관리 루트 객체
	this._tree_data = null;            // 트리 데이터
	this._callee = null;               // 호출자
	this._manager_callback = null;     // 관리 기능 콜백 처리용
	this._max_depth = 5;               // 최대 깊이
	this._toggleIcon = '<img onclick="%s.ToggleTree(this);" src="/assets/images/common/tree_images/tree_m.gif" class="plus" />';
	this._is_const = true;
};

OrgTree.prototype = {
	/**
	 * 호출자 변수명 설정
	 */
	setCallee: function(name)
	{
		if (typeof name != 'string')
		{
			alert('인수 형식이 올바르지 않습니다.');
			return;
		}

		this._callee = name;
	}



	,setTypeAsConst: function()
	{
		this._is_const = true;
	}



	,setTypeAsGroup: function()
	{
		this._is_const = false;
	}



	,setMaxDepth: function(depth)
	{
		this._max_depth = depth;
	}


	,getMaxDepth: function()
	{
		return this._max_depth;
	}



	/**
	 * 트리가 그려질 대상 객체 지정
	 */
	,setRootNode: function(obj)
	{
		if (typeof obj != 'object')
		{
			alert('루트 노드 객체를 지정해야 합니다.');
			return;
		}

		this._root_node = obj;
	}



	/**
	 * 트리 관리자 기능이 그려질 대상 객체 지정
	 */
	,setRootFunc: function(obj)
	{
		if (typeof obj != 'object')
		{
			alert('관리 노드 객체를 지정해야 합니다.');
			return;
		}

		this._root_func = obj;
	}



	/**
	 * 트리 노드의 ID 값 접두사 설정
	 */
	,setPrefixNode: function(prefix)
	{
		if (prefix.indexOf('_') > -1)
		{
			alert('접두사에 "_" 문자가 포함될 수 없습니다.');
			return;
		}

		this._prefix_node = prefix;
	}



	/**
	 * 관리 기능 노드의 ID 값 접두사 설정
	 */
	,setPrefixFunc: function(prefix)
	{
		if (prefix.indexOf('_') > -1)
		{
			alert('접두사에 "_" 문자가 포함될 수 없습니다.');
			return;
		}

		this._prefix_func = prefix;
	}



	/**
	 * 트리가 그려질 대상 객체 가져오기
	 */
	,getRootNode: function()
	{
		if (typeof this._root_node != 'object')
		{
			alert('루트 노드 객체가 선언되지 않았습니다.');
			return;
		}

		return this._root_node;
	}



	/**
	 * 트리 관리자 기능이 그려질 대상 객체 가져오기
	 */
	,getRootFunc: function()
	{
		if (typeof this._root_func != 'object')
		{
			alert('관리 노드 객체가 선언되지 않았습니다.');
			return;
		}

		return this._root_func;
	}



	/**
	 * 트리 노드의 ID 값 접두사 가져오기
	 */
	,getPrefixNode: function()
	{
		return this._prefix_node;
	}



	/**
	 * 관리 기능 노드의 ID 값 접두사 가져오기
	 */
	,getPrefixFunc: function()
	{
		return this._prefix_func;
	}



	/**
	 * 관리자 기능을 표시하도록 설정
	 */
	,showManager: function()
	{
		this._display_manager = true;
	}



	/**
	 * 관리자 기능을 표시하지 않도록 설정
	 */
	,hideManager: function()
	{
		this._display_manager = false;
	}



	/**
	 * 관리자 기능의 표시 여부를 반환
	 */
	,isShowManager: function()
	{
		return this._display_manager;
	}



	/**
	 * 그려질 트리 데이터 설정
	 */
	,setTreeData: function(data)
	{
		if (typeof data != 'object')
		{
			alert('데이터 형식이 올바르지 않습니다.');
			return;
		}

		this._tree_data = data;
	}



	/**
	 * 관리 기능을 수행할 콜백 지정
	 */
	,setManagerCallback: function(callback)
	{

		callback.setCallee(this);
		this._callback = callback;
	}



	/**
	 * 하위조직생성
	 */
	,add: function(obj)
	{
		this._callback.add(obj);
	}



	/**
	 * 관리자 설정
	 */
	,setAdmin: function(obj)
	{
		this._callback.setAdmin(obj);
	}



	/**
	 * 수정
	 */
	,update: function(obj)
	{
		this._callback.update(obj);
	}



	/**
	 * 삭제
	 */
	,remove: function(obj)
	{
		this._callback.remove(obj);
	}



	/**
	 * 위로 이동
	 */
	,promote: function(obj)
	{
		this._callback.promote(obj);
	}



	/**
	 * 아래로 이동
	 */
	,demote: function(obj)
	{
		this._callback.demote(obj);
	}



	/**
	 * 노드 항목 이름 클릭시
	 */
	,selectNode: function(obj)
	{
		try
		{
			this._callback.selectNode(obj);
		}
		catch (e)
		{

		}
	}



	/**
	 * 트리 그리기
	 */
	,draw: function(data, parent)
	{
		if (typeof data == 'undefined')   data = this._tree_data;
		if (typeof parent == 'undefined') parent = this.getRootNode();

		if (typeof data != 'object' || typeof parent != 'object')
		{
			alert('데이터 형식이 올바르지 않습니다.');
			return;
		}

		this._draw(data, parent);
	}



	/**
	 * 트리 그리기 내부 처리용 (재귀 호출)
	 */
	,_draw: function(node, parent)
	{
		var max = node.length;
		if (max < 1) return;

		try
		{
			var firstNode = parent.firstChild;

			if (firstNode != null)
			{
				if (firstNode.firstChild != null && firstNode.firstChild.nodeName != 'IMG')
					firstNode.innerHTML = this._toggleIcon.replace('%s', this._callee) + firstNode.innerHTML;

			}
		}
		catch (e)
		{
			alert(e + "ee" );
			// parent에 firstChild가 없을 경우의 예외 처리
		}
		finally
		{
			firstNode = null;
		}

		if (parent.lastChild != null && parent.lastChild.nodeName == 'UL')
		{
			var elm = parent.lastChild;

			try
			{
				elm.lastChild.className = '';
			}
			catch (e)
			{

			}

			if (this.isShowManager() === true)
			{
				var fn_elm = document.getElementById(parent.id.replace(this.getPrefixNode(), this.getPrefixFunc())).lastChild;
			}
		}
		else
		{
			var elm = document.createElement('UL');
			parent.appendChild(elm);

			if (this.isShowManager() === true)
			{
				var fn_elm = document.createElement('UL');
			}
		}

		if (this.isShowManager() === true)
		{
			if (parent == this.getRootNode())
			{
				this.getRootFunc().appendChild(fn_elm);
			}
			else
			{
				document.getElementById(parent.id.replace(this.getPrefixNode(), this.getPrefixFunc())).appendChild(fn_elm);
			}
		}

		for (var i = 0; i < max; i++)
		{
			var item = node[i];

			if (this.isShowManager() === true)
			{
				var fn_el = document.createElement('LI');
				var innerHTML = new Array();

				if (navigator.userAgent.indexOf('MSIE 6.0') > 0) fn_el.style.marginTop = '8px';

				innerHTML[innerHTML.length] = '<div class="container">';

				if (item.can_addsub === true)
				{
					innerHTML[innerHTML.length] = ('<a class="add" href="#" onclick="%s.add(this); return false;"><img src="/assets/images/korean/common/icon/' + (this._is_const === true ? 'org_add' : 'grp_add') + '.gif" alt="하위조직생성" title="" /></a>').replace('%s', this._callee);
				}
				/** IE에서 margin 오류 수정 */
				else if (Prototype.Browser.IE)
				{
					if ((fn_elm.children.length % 2) == 0)
					{
						if (navigator.userAgent.indexOf('MSIE 6.0') > 0)
						{
							fn_el.style.marginTop = '9px';
						}
						else if (navigator.userAgent.indexOf('MSIE 8.0') > 0)
						{
							fn_el.style.marginTop = '8px';
						}
					}
				}

				innerHTML[innerHTML.length] = ""; //'<a class="setadmin" href="#" onclick="%s.setAdmin(this); return false;"><img src="/assets/images/korean/org/btn_setadmin.gif" alt="관리자 설정" title="" /></a>'.replace('%s', this._callee);

				if (item.can_modify === true) innerHTML[innerHTML.length] = '<a class="update" href="#" onclick="%s.update(this); return false;"><img src="/assets/images/korean/common/icon/org_edit.gif" alt="수정" title="" /></a>'.replace('%s', this._callee);
				if (item.can_delete === true) innerHTML[innerHTML.length] = '<a class="remove" href="#" onclick="%s.remove(this); return false;"><img src="/assets/images/korean/common/icon/org_del.gif" tltle="삭제" title="" /></a>'.replace('%s', this._callee);
				if (item.can_move === true)
				{
					innerHTML[innerHTML.length] = '<a class="promote" href="#" onclick="%s.promote(this); return false;"><img src="/assets/images/korean/common/icon/org_up.gif" alt="▲" title="위로 이동" /></a>'.replace('%s', this._callee);
					innerHTML[innerHTML.length] = '<a class="demote" href="#" onclick="%s.demote(this); return false;"><img src="/assets/images/korean/common/icon/org_down.gif" alt="▼" title="아래로 이동" /></a>'.replace('%s', this._callee);
				}

				innerHTML[innerHTML.length] = '</div>';

				func_draw = innerHTML.join('');
				fn_el.innerHTML = innerHTML.join('');
				fn_el.id        = this.getPrefixFunc() + '_' + item.node_id;
				fn_elm.appendChild(fn_el);
			}

			var el = document.createElement('LI');

			if (parseInt(item.userCount, 10) > 0)
				el.innerHTML = '<strong onclick="%s.selectNode(this);">'.replace('%s', this._callee) + item.name + ' <span style="font-weight:normal; color:silver; font-size:8pt">(' + item.userCount + ')</span></strong>';// + func_draw;
			else
				el.innerHTML = '<strong onclick="%s.selectNode(this);">'.replace('%s', this._callee) + item.name + '</strong>';// + func_draw;

			el.id        = this.getPrefixNode() + '_' + item.node_id;
			elm.appendChild(el);

			if (item.childNodes !== false)
			{
				el.innerHTML = '<div class="container">' + el.innerHTML + '</div>';
				this._draw(item.childNodes, el);
			}
			else
			{
				el.innerHTML = '<div class="container">' + el.innerHTML + '</div>';
			}
		}

		elm.lastChild.className = 'last';
	}



	/**
	 * obj 노드의 펼치기 / 닫기 상태를 전환
	 */
	,ToggleTree: function(obj, force)
	{
		if (obj.nodeName == 'IMG')
		{
			img = obj;
			obj = img.parentNode.parentNode;
		}
		else
		{
			if (obj.childNodes.length < 1) return;
			else if (obj.firstChild.nodeName != 'DIV') return;
			else if (obj.firstChild.firstChild.nodeName != 'IMG') return;

			var img = obj.firstChild.firstChild;
		}

		if (force == 'collapse')    mode = 'collapse';
		else if (force == 'expand') mode = 'expand';
		else mode = (img.src.indexOf('tree_m') > 0) ? 'collapse' : 'expand';

		// 닫기
		if (mode == 'collapse')
		{
			img.src = img.src.replace('tree_m', 'tree_p');
			obj.lastChild.style.display = 'none';
			if (this.isShowManager() === true)
			{
				document.getElementById(obj.id.replace(this.getPrefixNode(), this.getPrefixFunc())).lastChild.style.display = 'none';
			}
		}
		// 펼치기
		else
		{
			img.src = img.src.replace('tree_p', 'tree_m');
			obj.lastChild.style.display = '';
			if (this.isShowManager() === true)
			{
				document.getElementById(obj.id.replace(this.getPrefixNode(), this.getPrefixFunc())).lastChild.style.display = '';
			}
		}
	}




	,expandReverse: function(obj)
	{
		while (true)
		{
			if (obj.lastChild.nodeName == 'UL')
			{
				obj.lastChild.style.display = '';
				obj.firstChild.firstChild.src = obj.firstChild.firstChild.src.replace('tree_p', 'tree_m');

				if (this.isShowManager() === true)
				{
					document.getElementById(obj.id.replace(this.getPrefixNode(), this.getPrefixFunc())).lastChild.style.display = '';
				}
			}

			if (obj.parentNode.nodeName == 'DIV') break;
			obj = obj.parentNode;
		}
	}



	/**
	 * from 노드를 to 하위로 이동함
	 */
	,move: function(from, to)
	{
		var node   = document.getElementById(this.getPrefixNode() + '_' + from);
		var parent = node.parentNode;
		var target = document.getElementById(this.getPrefixNode() + '_' + to);

		node.className = 'last';

		var lastChild = target.lastChild;
		if (lastChild.nodeName != 'UL')
		{
			var ul = document.createElement('UL');
			target.appendChild(ul);
			lastChild = target.lastChild;

			if (target.firstChild.firstChild.nodeName != 'IMG')
			{
				target.firstChild.innerHTML = this._toggleIcon.replace('%s', this._callee) + target.firstChild.innerHTML;
			}
		}
		else
		{
			lastChild.lastChild.className = '';
		}

		lastChild.appendChild(node);

		if (parent.childNodes.length < 1)
		{
			var _node = parent.parentNode.firstChild.firstChild;
			if (_node.nodeName == 'IMG') _node.parentNode.removeChild(_node);

			parent.parentNode.removeChild(parent);
		}
		else
		{
			parent.lastChild.className = 'last';
		}

		// 관리자 기능 이동
		if (this.isShowManager() === true)
		{
			var func   = document.getElementById(this.getPrefixFunc() + '_' + from);
			var parent = func.parentNode;
			var target = document.getElementById(this.getPrefixFunc() + '_' + to);

			var lastChild = target.lastChild;
			if (lastChild.nodeName != 'UL')
			{
				var ul = document.createElement('UL');
				target.appendChild(ul);
				lastChild = target.lastChild;
			}

			lastChild.appendChild(func);
			if (parent.childNodes.length < 1) parent.parentNode.removeChild(parent);

			// 관리자 전체 기능 활성화
			if (this.getDepth(node) < this.getMaxDepth())
			{
				if (func.firstChild.firstChild.className != 'add')
				{
					var elm = '<a class="add" href="#" onclick="%s.add(this); return false;"><img src="/assets/images/korean/common/icon/org_add.gif" alt="하위조직생성" title="" /></a>'.replace('%s', this._callee);
					func.firstChild.firstChild.insert({before: elm});
				}
			}
			// 제한적인 관리자 기능 변경
			else
			{
				if (func.firstChild.firstChild.className == 'add')
				{
					func.firstChild.removeChild(func.firstChild.firstChild);
				}
			}
		}

		this.expandReverse(node);
	}



	,getPath: function(obj)
	{
		if (obj.nodeName != 'STRONG')
		{
			try
			{
				obj = obj.firstChild.lastChild;
				if (obj.nodeName != 'STRONG') return '';
			}
			catch(e)
			{
				return ''; // fixme
			}
		}

		var path = new Array();
		var parent = obj;
		
		var idx = 0;
try
{
		while (true)
		{
			parent = parent.parentNode.parentNode;
			if (parent.nodeName != 'LI') break;

			obj = parent.firstChild.childNodes[parent.firstChild.firstChild.nodeName == 'IMG' ? 1 : 0];
	
			path[path.length] = obj.firstChild.data;
		}
} catch(E)
		{
	alert("path : " + E);
		}
		return path.reverse().join(' > ');
	}



	,getDepth: function(obj)
	{
		try
		{
			return this.getPath(obj).match(/ > /g).length + 1;
		}
		catch(e)
		{
			return 1;
		}
	}



	/**
	 * 지정한 하위 노드의 최대 깊이 수준을 가져옴
	 */
	,getChildMaxDepth: function(obj)
	{
		var depth = 0;

		if (typeof obj.lastChild == 'undefined') return 0;
		if (obj.lastChild.nodeName != 'UL') return 0;

		var max = obj.lastChild.childNodes.length;
		if (max < 1) return 0;

		for (var i = 0; i < max; i++)
		{
			var _depth = 1 + this.getChildMaxDepth(obj.lastChild.childNodes[i]);
			if (_depth > depth) depth = _depth;
		}

		return depth;
	}



	,getNode: function(node_id)
	{
		return document.getElementById(this.getPrefixNode() + '_' + node_id);
	}



	,getFunc: function(node_id)
	{
		return document.getElementById(this.getPrefixFunc() + '_' + node_id);
	}		
};