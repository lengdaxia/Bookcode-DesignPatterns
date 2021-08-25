
public class MulticastDelegate<ProtocolType> {
	
	internal class DelegateWrapper{
		weak var delegate: AnyObject?
		
		init(_ delegate: AnyObject?) {
			self.delegate = delegate
		}
	}
	
	
	private var delegateWrappers: [DelegateWrapper]
	
	private var delegaes: [ProtocolType]{
		delegateWrappers = delegateWrappers.filter({ dw in
			dw.delegate != nil
		})
		return delegateWrappers.map { dw in
			return dw.delegate!
		} as! [ProtocolType]
	}
	
	public init(delegates:[ProtocolType] = []){
		delegateWrappers = delegates.map({ d in
			return DelegateWrapper(d as AnyObject)
		})
	}
	
	public func addDelegate(_ delegate: ProtocolType){
		let wrapper = DelegateWrapper(delegate as AnyObject)
		delegateWrappers.append(wrapper)
	}
	
	public func removeDelegate(_ delegate: ProtocolType){
		guard let index = delegateWrappers.firstIndex(where: { d in
			return d.delegate === (delegate as AnyObject)
		}) else {
			return
		}
		
		delegateWrappers.remove(at: index)
	}
	
	public func invokeDelegates(_ closure: (ProtocolType) -> ()){
		delegaes.forEach { p in
			closure(p)
		}
	}
}
