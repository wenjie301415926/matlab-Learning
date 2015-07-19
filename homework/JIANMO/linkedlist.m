classdef linkedlist <handle
    
    properties (GetAccess = public, SetAccess = public)
       head
       tail
       size
    end
    
    methods
       %����һ���յ������ǹ��캯��
       function list = linkedlist()
           list.size=0;       
       end      
       %�������β�����һ��Ԫ��
       function append(list,node)
           if isempty(list.head)
                list.head=node;
                list.tail=node;
           else
                list.tail.next=node;
                list.tail=node;
           end
           list.size=list.size+1;
       end
       %�������ͷ��ɾ��һ��Ԫ��
            function temp=deletefromhead(list)
                    if isempty(list.head)
                         %disp('The linked list is empty');
                       temp=0;
                       list.size=0;
                      return;
                    else
                       temp=list.head;
                       list.head=list.head.next;
                       temp.next=[];
                      list.size=list.size-1;
                    end
            end
      end

end
