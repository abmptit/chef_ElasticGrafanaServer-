
package "elasticsearch"do
   action :remove
end

package "java-common"do
   action :remove
end

package "grafana"do
   action :remove
end

package "elasticsearch"do
   action :remove
end

file '/var/lib/grafana/grafana.db' do
    action :delete
end

directory '/var/lib/grafana/plugins' do
    recursive true
    action :delete
end
